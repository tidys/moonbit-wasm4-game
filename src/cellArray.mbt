struct CellArray {
  data : Array[Cell]
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
    // self.data.push(cellLine)
  }
  return 0
}

fn CellArray::addCell(self : CellArray, cell : Cell) -> Int {
  self.data.push(cell)
  return 0
}

fn CellArray::getCell(self : CellArray, row : Int, col : Int) -> Cell {
  for cell in self.data {
    if cell.row == row && cell.col == col {
      return cell
    }
  }
  return Cell::new()
}

fn CellArray::hasBottomCell(self : CellArray, cell : Cell) -> Bool {
  if cell.row + 1 < cellRow {
    return true
    // let bottom = self.data[cell.row + 1][cell.col]
    // return bottom.valid()
  }
  return false
}

fn CellArray::getBottomCell(self : CellArray, cell : Cell) -> Cell {
  return self.getCell(cell.row + 1, cell.col)
}

fn CellArray::allCellIsMoving(self : CellArray) -> Bool {
  for cell in self.data {
    if cell.isInRightPosition() {

    } else {
      return true
    }
  }
  return false
}

fn CellArray::moveDown(self : CellArray) -> Int {
  let mut ret = 0
  for row = cellRow - 2; row >= 0; row = row - 1 {
    for col = 0; col < cellCol; col = col + 1 {
      let cell_cur = self.getCell(row, col)
      if cell_cur.valid() {
        let cell_bottom : Cell = self.getBottomCell(cell_cur)
        if cell_bottom.valid() {
          if cell_bottom.sameNumber(cell_cur) {
            ret = cell_cur.moveTo(cell_bottom, cell_cur.number * 2)
          }
        } else {
          ret = cell_cur.moveDown()
        }
      }
    }
  }
  return ret
}

// row 和 row_target 不相等的重置了
fn CellArray::moveEnd(self : CellArray) -> Int {
  let mut i = 0
  for ; i < self.data.length(); {
    let cell = self.data[i]
    cell.number = cell.target_numbre
    if cell.remove == 1 {
      cell.removeNode() |> ignore
      self.data.remove(i) |> ignore
    } else {
      i = i + 1
    }
  }
  self.log() |> ignore
  return 0
}

fn CellArray::log(self : CellArray) -> Int {
  for cell in self.data {
    @wasm4.trace(
      "(" +
      cell.row.to_string() +
      "," +
      cell.col.to_string() +
      ") : " +
      cell.number.to_string(),
    )
  }
  return 0
}

fn CellArray::removeCell(self : CellArray, cell : Cell) -> Int {
  return 0
}

fn CellArray::resetRemove(self : CellArray, v : Int) -> Int {
  for cell in self.data {
    cell.remove = v
  }
  return 0
}

fn CellArray::fillCellFirst(self : CellArray) -> Int {
  for cell in self.data {
    if cell.valid() {

    } else {
      let cell = Cell::new()
      let a = cell.init(cell.row, cell.col)
      // self.data[cell.row][cell.col] = cell
      return 0
    }
  }
  return 0
}

fn CellArray::randomGen(self : CellArray) -> Int {
  return 0
}
