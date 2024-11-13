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
    self.gameData.stage = stage_move
  }
  if @wasm4.get_gamepad(index=1).button_left {
    self.gameData.stage = stage_move
  }
  if @wasm4.get_gamepad(index=1).button_down {
    ret = self.cellArray.moveDown()
    self.gameData.stage = stage_move
  }
  if @wasm4.get_gamepad(index=1).button_up {
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
