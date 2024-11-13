let cellWidth : Int = 32

let cellHeight : Int = 32

let space : Int = 2

let cellRow : Int = 4

let cellCol : Int = 4

let cellTotalWidth : Int = (cellCol - 1) * space + cellCol * cellWidth

let cellTotalHeight : Int = (cellRow - 1) * space + cellRow * cellHeight

let offsetX : Int = (160 - cellTotalWidth) / 2

let offsetY : Int = (160 - cellTotalHeight) / 2

struct Cell {
  mut row : Int
  mut col : Int
  mut number : Int
  mut target_numbre : Int
  mut remove : Int
  mut x : Int
  mut y : Int
  mut width : Int
  mut height : Int
  mut nodeID : Int
}

fn Cell::new() -> Cell {
  return {
    row: 0,
    col: 0,
    number: 0,
    target_numbre: 0,
    remove: 0,
    x: 0,
    y: 0,
    width: 0,
    height: 0,
    nodeID: 0,
  }
}

fn Cell::init(self : Cell, row : Int, col : Int, num:Int) -> Int {
  self.remove = 0
  self.row = row
  self.col = col
  self.x = self.posX()
  self.y = self.posY()
  self.width = cellWidth
  self.height = cellHeight
  self.number = num
  self.target_numbre = num
  return 0
}

fn Cell::setNodeID(self : Cell, node : Int) -> Int {
  self.nodeID = node
  return 0
}

fn Cell::posX(self : Cell) -> Int {
  return (cellWidth + space) * self.col + offsetX
}

fn Cell::posY(self : Cell) -> Int {
  return (cellHeight + space) * self.row + offsetY + 4
}

fn Cell::valid(self : Cell) -> Bool {
  if self.number <= 0 {
    return false
  }
  return true
}

fn Cell::sameNumber(self : Cell, cell : Cell) -> Bool {
  return self.number == cell.number
}

fn Cell::isInRightPosition(self : Cell) -> Bool {
  let targetX = self.posX()
  let targetY = self.posY()
  for node in engine.nodeArray {
    if node.x == targetX && node.y == targetY && node.id == self.nodeID {
      return true
    }
  }
  return false
}

fn Cell::removeNode(self : Cell) -> Int {
  let mut i = 0
  for ; i < engine.nodeArray.length(); {
    let node = engine.nodeArray[i]
    if node.id == self.nodeID {
      engine.nodeArray.remove(i) |> ignore
      // @wasm4.trace(
      //   "remove node " +
      //   self.nodeID.to_string() +
      //   "[" +
      //   engine.nodeArray.length().to_string() +
      //   "]",
      // )
    } else {
      i = i + 1
    }
  }
  return 0
}

fn Cell::moveTo(self : Cell, cell : Cell, number : Int) -> Int {
  self.row = cell.row
  self.col = cell.col
  self.target_numbre = number
  engine.gameData.score = engine.gameData.score + self.number
  cell.remove = 1
  return 0
}

fn Cell::moveDown(self : Cell) -> Int {
  self.row = self.row + 1
  return 0
}

fn Cell::moveUp(self : Cell) -> Int {
  self.row = self.row - 1
  return 0
}

fn Cell::moveLeft(self : Cell) -> Int {
  self.col = self.col - 1
  return 0
}

fn Cell::moveRight(self : Cell) -> Int {
  self.col = self.col + 1
  return 0
}
