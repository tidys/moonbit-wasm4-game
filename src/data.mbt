let cellArray : Array[Array[Cell]] = []

let cellRow : Int = 4

let cellCol : Int = 4

let space = 2

let cellTotalWidth : Int = (cellCol - 1) * space + cellCol * cellWidth

let cellTotalHeight : Int = (cellRow - 1) * space + cellRow * cellHeight

let offsetX : Int = (160 - cellTotalWidth) / 2

let offsetY : Int = (160 - cellTotalHeight) / 2

fn getCellPosX(col : Int) -> Int {
  return (cellWidth + space) * col + offsetX
}

fn getCellPosY(row : Int) -> Int {
  return (cellHeight + space) * row + offsetY + 5
}

pub fn initCell() -> Int {
  for row = 0; row < cellRow; row = row + 1 {
    let cellLine : Array[Cell] = []
    for col = 0; col < cellCol; col = col + 1 {
      let cell : Cell = {
        row: 0,
        col: 0,
        x: 0,
        y: 0,
        width: 10,
        height: 10,
        number: 1,
      }
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

pub fn cellDown() -> Int {
  for row = 0; row < cellRow; row = row + 1 {
    for col = 0; col < cellCol; col = col + 1 {
      let cell_cur : Cell = cellArray[row][col]
      if cellHasBottom(cell_cur) {
        // 有botton
        let cell_bottom : Cell = cellBottom(cell_cur)
        if cellSame(cell_bottom, cell_cur) {
          cell_cur.number = cell_cur.number * 2
        }
      }
    }
  }
  return 0
}
