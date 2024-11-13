struct Engine {
  gameData : GameData
  cellArray : CellArray
  nodeArray : Array[Node]
}

fn Engine::new() -> Engine {
  return {
    gameData: GameData::new(),
    cellArray: CellArray::new(),
    nodeArray: [],
  }
}

fn Engine::init(self : Engine) -> Int {
  let mut ret = 0
  ret = self.cellArray.init()
  ret = self.createNode()
  return 0
}

fn Engine::createNode(self : Engine) -> Int {
  for row = 0; row < cellRow; row = row + 1 {
    for col = 0; col < cellCol; col = col + 1 {
      self.makeNode(row, col) |> ignore
    }
  }
  return 0
}

fn Engine::makeNode(self : Engine, row : Int, col : Int) -> Int {
  let cell : Cell = Cell::new()
  cell.init(row, col) |> ignore
  let node : Node = Node::new()
  node.init(row, col, cellWidth, cellHeight) |> ignore
  node.setCell(cell) |> ignore
  cell.setNodeID(node.id) |> ignore
  self.nodeArray.push(node)
  self.cellArray.addCell(cell) |> ignore
  return 0
}

fn Engine::drawUI(self : Engine) -> Int {
  @wasm4.set_draw_colors(index=1, color_ScoreText)
  @wasm4.text("Score:" + self.gameData.score.to_string(), 2, 2)
  return 0
}

fn Engine::drawBg(self : Engine) -> Int {
  @wasm4.set_draw_colors(index=1, color_StageBg)
  let offset = (168 - cellTotalWidth) / 2
  // @wasm4.rect(offset, 0, 168 - offset * 2, 168)
  return 0
}

fn Engine::renderCell(self : Engine) -> Int {
  let mut ret : Int = 0
  for node in self.nodeArray {
    ret = node.draw()
  }
  return ret
}

fn Engine::moveStep(self : Engine) -> Int {
  for node in self.nodeArray {
    let cell : Cell = node.cell
    if node.x < cell.posX() {
      node.x = node.x + 1
    } else if node.x > cell.posX() {
      node.x = node.x - 1
    }
    if node.y < cell.posY() {
      node.y = node.y + 1
    } else if node.y > cell.posY() {
      node.y = node.y - 1
    }
  }
  return 0
}

fn Engine::watchInput(self : Engine) -> Int {
  let mut ret : Int = 0
  if @wasm4.get_gamepad(index=1).button_right {
    self.cellArray.moveRight() |> ignore
    self.gameData.stage = stage_move
  }
  if @wasm4.get_gamepad(index=1).button_left {
    self.cellArray.moveLeft() |> ignore
    self.gameData.stage = stage_move
  }
  if @wasm4.get_gamepad(index=1).button_down {
    ret = self.cellArray.moveDown()
    self.gameData.stage = stage_move
  }
  if @wasm4.get_gamepad(index=1).button_up {
    self.cellArray.moveUp() |> ignore
    self.gameData.stage = stage_move
  }
  return ret
}

fn Engine::debug(self : Engine, text : String) -> Int {
  @wasm4.set_draw_colors(index=1, 3)
  @wasm4.text(text, 80, 2)
  return 0
}

fn Engine::turnStage(self : Engine, stage : Int) -> Int {
  self.gameData.stage = stage
  return 0
}
