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
  mut target_row : Int
  mut target_col : Int
  mut target_numbre : Int
  mut dirty : Int
  mut x : Int
  mut y : Int
  mut width : Int
  mut height : Int
}

fn Cell::new() -> Cell {
  return {
    row: 0,
    col: 0,
    number: 2,
    target_row: 0,
    target_col: 0,
    target_numbre: 2,
    dirty: 0,
    x: 0,
    y: 0,
    width: 10,
    height: 10,
  }
}

fn Cell::init(self : Cell, row : Int, col : Int) -> Int {
  self.dirty = 0
  self.target_row = row
  self.target_col = col
  self.row = row
  self.col = col
  self.x = self.posX()
  self.y = self.posY()
  self.width = cellWidth
  self.height = cellHeight
  self.number = 2
  self.target_numbre = 2
  return 0
}

fn Cell::posX(self : Cell) -> Int {
  return (cellWidth + space) * self.col + offsetX
}

fn Cell::posY(self : Cell) -> Int {
  return (cellHeight + space) * self.row + offsetY + 4
}

fn Cell::targetPosX(self : Cell) -> Int {
  return (cellWidth + space) * self.target_col + offsetX
}

fn Cell::targetPosY(self : Cell) -> Int {
  return (cellHeight + space) * self.target_row + offsetY + 4
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
  let targetX = self.targetPosX()
  let targetY = self.targetPosY()
  if self.x != targetX || self.y != targetY {
    return false
  } else {
    return true
  }
}

fn Cell::moveTo(self : Cell, target : Cell, number : Int) -> Int {
  self.target_row = target.row
  self.target_col = target.col
  self.target_numbre = number
  self.dirty = 1
  target.dirty = 1
  return 0
}

fn Cell::isDirty(self : Cell) -> Bool {
  return self.dirty != 0
}

fn Cell::isNotDirty(self : Cell) -> Bool {
  return self.dirty == 0
}

// 绘制格子
fn Cell::draw(self : Cell) -> Int {
  @wasm4.set_draw_colors(index=1, color_CellBg)
  @wasm4.rect(self.x, self.y, self.width, self.height)
  let mut textWidth : Int = 0
  let mut n : Int = self.number
  let charSize : Int = 8
  while n != 0 {
    textWidth = textWidth + charSize
    n = n / 10
  }
  @wasm4.set_draw_colors(index=1, color_CellText)
  @wasm4.text(
    self.number.to_string(),
    self.x + (self.width - textWidth) / 2,
    self.y + (self.height - charSize) / 2,
  )
  return 0
}

fn Cell::isMoveType(cell : Cell) -> Bool {
  return cell.row != cell.target_row || cell.col != cell.target_col
}
