let cellArray : Array[Array[Cell]] = []

let cellRow : Int = 4

let cellCol : Int = 4

let space : Int = 2

let cellTotalWidth : Int = (cellCol - 1) * space + cellCol * cellWidth

let cellTotalHeight : Int = (cellRow - 1) * space + cellRow * cellHeight

let offsetX : Int = (160 - cellTotalWidth) / 2

let offsetY : Int = (160 - cellTotalHeight) / 2

fn getCellPosX(col : Int) -> Int {
  return (cellWidth + space) * col + offsetX
}

fn getCellPosY(row : Int) -> Int {
  return (cellHeight + space) * row + offsetY + 4
}

pub fn initCell() -> Int {
  for row = 0; row < cellRow; row = row + 1 {
    let cellLine : Array[Cell] = []
    for col = 0; col < cellCol; col = col + 1 {
      let cell : Cell = {
        row: 0,
        col: 0,
        row_target: 0,
        col_target: 0,
        dirty: 0,
        x: 0,
        y: 0,
        width: 10,
        height: 10,
        number: 1,
      }
      cell.dirty = 0
      cell.row_target = row
      cell.col_target = col
      cell.row = row
      cell.col = col
      cell.x = getCellPosX(col)
      cell.y = getCellPosY(row)
      cell.width = cellWidth
      cell.height = cellHeight
      cell.number = 2
      cellLine.push(cell)
    }
    cellArray.push(cellLine)
  }
  return 0
}

pub fn cellValid(cell : Cell) -> Bool {
  if cell.number <= 0 {
    return false
  }
  return true
}

pub fn cellHasBottom(cell : Cell) -> Bool {
  if cell.row + 1 < cellRow {
    return true
  }
  return false
}

pub fn cellBottom(cell : Cell) -> Cell {
  let row = cell.row
  return cellArray[row + 1][cell.col]
}

pub fn cellSame(cell1 : Cell, cell2 : Cell) -> Bool {
  return cell1.number == cell2.number
}

pub fn isCellInRightPosition(cell : Cell) -> Bool {
  let targetX = getCellPosX(cell.col_target)
  let targetY = getCellPosY(cell.row_target)
  if cell.x != targetX || cell.y != targetY {
    return false
  } else {
    return true
  }
}

pub fn allCellIsMoving() -> Bool {
  for cellLine in cellArray {
    for cell in cellLine {
      if isCellInRightPosition(cell) {

      } else {
        return true
      }
    }
  }
  return false
}

pub fn cellDown() -> Int {
  for row = 0; row < cellRow; row = row + 1 {
    for col = 0; col < cellCol; col = col + 1 {
      let cell_cur : Cell = cellArray[row][col]
      if cellHasBottom(cell_cur) {
        // 有bottom
        let cell_bottom : Cell = cellBottom(cell_cur)
        if cell_cur.dirty == 0 &&
          cell_bottom.dirty == 0 &&
          cellSame(cell_bottom, cell_cur) {
          cell_cur.row_target = cell_bottom.row
          cell_cur.col_target = cell_bottom.col
          cell_cur.dirty = 1
          cell_bottom.dirty = 1
        }
      }
    }
  }
  return 0
}

// row 和 row_target 不相等的重置了
pub fn moveEnd() -> Int {
  for cellLine in cellArray {
    for cell in cellLine {
      if cell.row != cell.row_target || cell.col != cell.col_target {
        cell.number = 0
        let target = cellArray[cell.row_target][cell.col_target]
        target.number = target.number * 2
      }
    }
  }
  return 0
}

pub fn resetDirty(v : Int) -> Int {
  for cellLine in cellArray {
    for cell in cellLine {
      cell.dirty = v
    }
  }
  return 0
}

pub fn cellStep() -> Int {
  for cellLine in cellArray {
    for cell in cellLine {
      if isCellInRightPosition(cell) {

      } else {
        if cell.col < cell.col_target {
          cell.x = cell.x + 1
        } else if cell.col > cell.col_target {
          cell.x = cell.x - 1
        }
        if cell.row < cell.row_target {
          cell.y = cell.y + 1
        } else if cell.row > cell.row_target {
          cell.y = cell.y - 1
        }
      }
    }
  }
  return 0
}
