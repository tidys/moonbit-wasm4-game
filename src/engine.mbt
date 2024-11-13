struct Engine {
  gameData : GameData
  cellArray : CellArray
}

fn Engine::new() -> Engine {
  return { gameData: GameData::new(), cellArray: CellArray::new() }
}

fn Engine::init(self : Engine) -> Int {
  let mut ret = 0
  ret = self.cellArray.init()
  return 0
}

fn Engine::drawUI(self : Engine) -> Int {
  @wasm4.set_draw_colors(index=1, 4)
  @wasm4.text("Score:" + self.gameData.score.to_string(), 2, 2)
  return 0
}

fn Engine::renderCell(self : Engine) -> Int {
  let mut ret : Int = 0
  for cellLine in self.cellArray.data {
    for cell in cellLine {
      ret = cell.draw()
    }
  }
  return ret
}

fn Engine::watchInput(self : Engine) -> Int {
  let mut ret : Int = 0
  if @wasm4.get_gamepad(index=1).button_right {

  }
  if @wasm4.get_gamepad(index=1).button_left {

  }
  if @wasm4.get_gamepad(index=1).button_down {
    ret = self.cellArray.moveDown()
    self.gameData.stage = stage_move
  }
  if @wasm4.get_gamepad(index=1).button_up {

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
