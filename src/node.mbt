struct Node {
  mut id : Int
  mut x : Int
  mut y : Int
  mut width : Int
  mut height : Int
  mut cell : Cell
}

fn Node::new() -> Node {
  return { x: 0, y: 0, id: 0, width: 0, height: 0, cell: Cell::new() }
}

fn Node::init(self : Node, x : Int, y : Int, width : Int, height : Int) -> Int {
  self.x = x
  self.y = y
  self.width = width
  self.height = height
  self.id = engine.gameData.getNodeID()
  return 0
}

fn Node::setCell(self : Node, cell : Cell) -> Int {
  self.cell = cell
  self.x = cell.posX()
  self.y = cell.posY()
  return 0
}

// 绘制格子
fn Node::draw(self : Node) -> Int {
  @wasm4.set_draw_colors(index=1, color_CellBg)
  @wasm4.rect(self.x, self.y, self.width, self.height)
  let mut textWidth : Int = 0
  let mut n : Int = self.cell.number
  let charSize : Int = 8
  while n != 0 {
    textWidth = textWidth + charSize
    n = n / 10
  }
  @wasm4.set_draw_colors(index=1, color_CellText)
  @wasm4.text(
    self.cell.number.to_string(),
    self.x + (self.width - textWidth) / 2,
    self.y + (self.height - charSize) / 2,
  )
  return 0
}
