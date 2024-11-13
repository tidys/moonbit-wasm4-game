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
  mut row_target : Int
  mut col_target : Int
  mut dirty : Int
  mut x : Int
  mut y : Int
  mut width : Int
  mut height : Int
  mut number : Int
}

fn Cell::new() -> Cell {
  return {
    row: 0,
    col: 0,
    row_target: 0,
    col_target: 0,
    dirty: 0,
    x: 0,
    y: 0,
    width: 10,
    height: 10,
    number: 2,
  }
}

fn Cell::init(self : Cell, row : Int, col : Int) -> Int {
  self.dirty = 0
  self.row_target = row
  self.col_target = col
  self.row = row
  self.col = col
  self.x = self.posX()
  self.y = self.posY()
  self.width = cellWidth
  self.height = cellHeight
  self.number = 2
  return 0
}

fn Cell::posX(self : Cell) -> Int {
  return (cellWidth + space) * self.col + offsetX
}

fn Cell::posY(self : Cell) -> Int {
  return (cellHeight + space) * self.row + offsetY + 4
}

fn Cell::targetPosX(self : Cell) -> Int {
  return (cellWidth + space) * self.col_target + offsetX
}

fn Cell::targetPosY(self : Cell) -> Int {
  return (cellHeight + space) * self.row_target + offsetY + 4
}

fn Cell::valid(self : Cell) -> Bool {
  if self.number <= 0 {
    return false
  }
  return true
}

fn Cell::same(self : Cell, cell : Cell) -> Bool {
  return self.number == cell.number
}

fn Cell::isInRightPosition(self : Cell) -> Bool {
  let targetX = self.targetPosX()
  let targetY = self.targetPosY()
  if self.x != targetX || self.y != targetY {
    return false
  } else {
    return true
  }
}

fn Cell::isDirty(self : Cell) -> Bool {
  return self.dirty != 0
}

fn Cell::isNotDirty(self : Cell) -> Bool {
  return self.dirty == 0
}

// 绘制格子
fn Cell::draw(self : Cell) -> Int {
  @wasm4.set_draw_colors(index=1, 3)
  @wasm4.rect(self.x, self.y, self.width, self.height)
  @wasm4.set_draw_colors(index=1, 2)
  let mut textWidth : Int = 0
  let mut n : Int = self.number
  let charSize : Int = 8
  while n != 0 {
    textWidth = textWidth + charSize
    n = n / 10
  }
  @wasm4.text(
    self.number.to_string(),
    self.x + (self.width - textWidth) / 2,
    self.y + (self.height - charSize) / 2,
  )
  return 0
}
