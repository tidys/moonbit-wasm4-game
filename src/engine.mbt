struct Engine {
  gameData : GameData
  cellArray : CellArray
  nodeArray : Array[Node]
  mut hasMove : Int
  mut isGameOver : Int
  mut count : Int
}

fn Engine::new() -> Engine {
  return {
    gameData: GameData::new(),
    cellArray: CellArray::new(),
    nodeArray: [],
    hasMove: 0,
    isGameOver: 0,
    count: 0,
  }
}

fn Engine::init(self : Engine) -> Int {
  self.createNode() |> ignore
  return 0
}

fn Engine::createNode(self : Engine) -> Int {
  for row = 0; row < cellRow; row = row + 1 {
    for col = 0; col < cellCol; col = col + 1 {
      self.makeNode(row, col, 2) |> ignore
    }
  }
  return 0
}

fn Engine::makeNode(self : Engine, row : Int, col : Int, num : Int) -> Cell {
  let cell : Cell = Cell::new()
  cell.init(row, col, num) |> ignore
  let node : Node = Node::new()
  node.init(row, col, cellWidth, cellHeight) |> ignore
  node.setCell(cell) |> ignore
  cell.setNodeID(node.id) |> ignore
  self.nodeArray.push(node)
  self.cellArray.addCell(cell) |> ignore
  return cell
}

fn Engine::drawUI(self : Engine) -> Int {
  @wasm4.set_draw_colors(index=1, color_ScoreText)
  @wasm4.text("Score:" + self.gameData.score.to_string(), 2, 2)
  if self.hasMove == 0 {
    @wasm4.set_draw_colors(index=1, color_ScoreText)
    @wasm4.text("press arrow keys", 15, 152)
  }
  return 0
}

fn Engine::reset(self : Engine) -> Int {
  self.hasMove = 0
  self.gameData.score = 0
  self.gameData.stage = stage_idle
  self.isGameOver = 0
  self.cellArray.reset() |> ignore
  self.count = 0
  return 0
}

fn Engine::drawBg(self : Engine) -> Int {
  @wasm4.set_draw_colors(index=1, color_StageBg)
  @wasm4.rect(11, 15, 138, 138)
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
    self.hasMove = 1
    self.btnSound() |> ignore
  }
  if @wasm4.get_gamepad(index=1).button_left {
    self.cellArray.moveLeft() |> ignore
    self.gameData.stage = stage_move
    self.hasMove = 1
    self.btnSound() |> ignore
  }
  if @wasm4.get_gamepad(index=1).button_down {
    ret = self.cellArray.moveDown()
    self.gameData.stage = stage_move
    self.btnSound() |> ignore
    self.hasMove = 1
  }
  if @wasm4.get_gamepad(index=1).button_up {
    self.cellArray.moveUp() |> ignore
    self.gameData.stage = stage_move
    self.hasMove = 1
    self.btnSound() |> ignore
  }
  if @wasm4.get_gamepad(index=1).button_1 {
    // press x
    // if self.cellArray.isFull() {
    //   @wasm4.trace("full")
    // } else {
    //   @wasm4.trace("not full")
    // }
    // if self.cellArray.isSameNumberLink() {
    //   @wasm4.trace("link")
    // } else {
    //   @wasm4.trace("not link")
    // }
  }
  return ret
}

fn Engine::btnSound(self : Engine) -> Int {
  @wasm4.tone(
    (100, 400),
    @wasm4.ADSR::new(5),
    @wasm4.ADSRVolume::new(100),
    @wasm4.ToneFlag::new(),
  )
  return 0
}

fn Engine::watchGameOver(self : Engine) -> Int {
  if @wasm4.get_gamepad(index=1).button_1 {
    self.reset() |> ignore
  }
  return 0
}

fn Engine::debug(self : Engine, text : String) -> Int {
  // @wasm4.set_draw_colors(index=1, 3)
  // @wasm4.text(text, 80, 2)
  return 0
}

fn Engine::turnStage(self : Engine, stage : Int) -> Int {
  self.gameData.stage = stage
  return 0
}
