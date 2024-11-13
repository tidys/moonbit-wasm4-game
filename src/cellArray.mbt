struct CellArray {
  data : Array[Array[Cell]]
}

fn CellArray::new() -> CellArray {
  return { data: [] }
}

fn CellArray::init(self : CellArray) -> Int {
  for row = 0; row < cellRow; row = row + 1 {
    let cellLine : Array[Cell] = []
    for col = 0; col < cellCol; col = col + 1 {
      let cell : Cell = Cell::new()
      let a = cell.init(row, col)
      cellLine.push(cell)
    }
    self.data.push(cellLine)
  }
  return 0
}

fn CellArray::cellHasBottom(self : CellArray, cell : Cell) -> Bool {
  if cell.row + 1 < cellRow {
    let bottom = self.data[cell.row + 1][cell.col]
    return bottom.valid()
  }
  return false
}

fn CellArray::cellBottom(self : CellArray, cell : Cell) -> Cell {
  let row = cell.row
  return self.data[row + 1][cell.col]
}

fn CellArray::allCellIsMoving(self : CellArray) -> Bool {
  for cellLine in self.data {
    for cell in cellLine {
      if cell.isInRightPosition() {

      } else {
        return true
      }
    }
  }
  return false
}

fn CellArray::moveDown(self : CellArray) -> Int {
  for row = 0; row < cellRow; row = row + 1 {
    for col = 0; col < cellCol; col = col + 1 {
      let cell_cur : Cell = self.data[row][col]
      if cell_cur.valid() && self.cellHasBottom(cell_cur) {
        // 有bottom
        let cell_bottom : Cell = self.cellBottom(cell_cur)
        if cell_cur.isNotDirty() &&
          cell_bottom.isNotDirty() &&
          cell_bottom.same(cell_cur) {
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
fn CellArray::moveEnd(self : CellArray) -> Int {
  for cellLine in self.data {
    for cell in cellLine {
      if cell.row != cell.row_target || cell.col != cell.col_target {
        cell.number = 0
        let target = self.data[cell.row_target][cell.col_target]
        target.number = target.number * 2
      }
    }
  }
  return 0
}

fn CellArray::resetDirty(self : CellArray, v : Int) -> Int {
  for cellLine in self.data {
    for cell in cellLine {
      cell.dirty = v
    }
  }
  return 0
}

fn CellArray::cellStep(self : CellArray) -> Int {
  for cellLine in self.data {
    for cell in cellLine {
      if cell.isInRightPosition() {

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
