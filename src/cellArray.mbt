struct CellArray {
  data : Array[Cell]
}

fn CellArray::new() -> CellArray {
  return { data: [] }
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
  for row = cellRow - 2; row >= 0; row = row - 1 {
    for col = 0; col < cellCol; col = col + 1 {
      let cell_cur = self.getCell(row, col)
      if cell_cur.valid() {
        let cell_bottom : Cell = self.getCell(cell_cur.row + 1, cell_cur.col)
        if cell_bottom.valid() {
          if cell_bottom.sameNumber(cell_cur) {
            cell_cur.moveTo(cell_bottom, cell_cur.number * 2) |> ignore
          }
        } else {
          cell_cur.moveDown() |> ignore
        }
      }
    }
  }
  return 0
}

fn CellArray::moveUp(self : CellArray) -> Int {
  for row = 1; row < cellRow; row = row + 1 {
    for col = 0; col < cellCol; col = col + 1 {
      let cell_cur = self.getCell(row, col)
      if cell_cur.valid() {
        let cell_top : Cell = self.getCell(cell_cur.row - 1, cell_cur.col)
        if cell_top.valid() {
          if cell_top.sameNumber(cell_cur) {
            cell_cur.moveTo(cell_top, cell_cur.number * 2) |> ignore
          }
        } else {
          cell_cur.moveUp() |> ignore
        }
      }
    }
  }
  return 0
}

fn CellArray::moveLeft(self : CellArray) -> Int {
  for col = 1; col < cellCol; col = col + 1 {
    for row = 0; row < cellRow; row = row + 1 {
      let cell_cur = self.getCell(row, col)
      if cell_cur.valid() {
        let cell_left : Cell = self.getCell(cell_cur.row, cell_cur.col - 1)
        if cell_left.valid() {
          if cell_left.sameNumber(cell_cur) {
            cell_cur.moveTo(cell_left, cell_cur.number * 2) |> ignore
          }
        } else {
          cell_cur.moveLeft() |> ignore
        }
      }
    }
  }
  return 0
}

fn CellArray::moveRight(self : CellArray) -> Int {
  for col = cellCol - 2; col >= 0; col = col - 1 {
    for row = 0; row < cellRow; row = row + 1 {
      let cell_cur = self.getCell(row, col)
      if cell_cur.valid() {
        let cell_right : Cell = self.getCell(cell_cur.row, cell_cur.col + 1)
        if cell_right.valid() {
          if cell_right.sameNumber(cell_cur) {
            cell_cur.moveTo(cell_right, cell_cur.number * 2) |> ignore
          }
        } else {
          cell_cur.moveRight() |> ignore
        }
      }
    }
  }
  return 0
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
  // self.log() |> ignore
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

fn CellArray::resetRemove(self : CellArray, v : Int) -> Int {
  for cell in self.data {
    cell.remove = v
  }
  return 0
}

fn CellArray::reset(self : CellArray) -> Int {
  for row = 0; row < cellRow; row = row + 1 {
    for col = 0; col < cellCol; col = col + 1 {
      let mut cell = self.getCell(row, col)
      if not(cell.valid()) {
        cell = engine.makeNode(row, col, 2)
      }
      cell.init(row, col, 2) |> ignore
    }
  }
  return 0
}

// 判断是否填满，判断是否有相连相同的数字
fn CellArray::isFull(self : CellArray) -> Bool {
  for row = 0; row < cellRow; row = row + 1 {
    for col = 0; col < cellCol; col = col + 1 {
      let a = self.getCell(row, col)
      if a.valid() {

      } else {
        return false
      }
    }
  }
  return true
}

fn CellArray::isSameNumberLink(self : CellArray) -> Bool {
  for row = 0; row < cellRow; row = row + 1 {
    for col = 0; col < cellCol; col = col + 1 {
      let cell = self.getCell(row, col)
      // 看上下左右是否有数字相同的
      let cell_up : Cell = self.getCell(cell.row - 1, cell.col)
      if cell_up.valid() && cell_up.sameNumber(cell) {
        return true
      }
      let cell_down : Cell = self.getCell(cell.row + 1, cell.col)
      if cell_down.valid() && cell_down.sameNumber(cell) {
        return true
      }
      let cell_left : Cell = self.getCell(cell.row, cell.col - 1)
      if cell_left.valid() && cell_left.sameNumber(cell) {
        return true
      }
      let cell_right : Cell = self.getCell(cell.row, cell.col + 1)
      if cell_right.valid() && cell_right.sameNumber(cell) {
        return true
      }
    }
  }
  return false
}

fn CellArray::fillCellRandom(self : CellArray) -> Int {
  let arr : Array[Array[Int]] = []
  for row = 0; row < cellRow; row = row + 1 {
    for col = 0; col < cellCol; col = col + 1 {
      let a = self.getCell(row, col)
      if a.valid() {

      } else {
        arr.push([row, col])
      }
    }
  }
  if arr.length() > 0 {
    let idx : Int = 15 % arr.length()
    let target = arr[idx]
    let row = target[0]
    let col = target[1]
    let number = self.randomNumer(arr.length())
    engine.makeNode(row, col, number) |> ignore
  }
  return 0
}

fn CellArray::randomNumer(self : CellArray, base : Int) -> Int {
  let numberArray = [2, 4, 8, 16]
  let a = base
  let b = numberArray.length() - 1
  // @wasm4.trace(a.to_string() + "%" + b.to_string())
  let numIdx = a % b
  // @wasm4.trace(numIdx.to_string())
  return numberArray[numIdx]
}

fn CellArray::randomGen(self : CellArray) -> Int {
  return 0
}
