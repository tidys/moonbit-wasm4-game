let engine : Engine = Engine::new()

pub fn start() -> Int {
  // @wasm4.set_palette(1, @wasm4.rgb(0xff0000))
  let ret : Int = engine.init()
  return 0
}

pub fn update() -> Int {
  let mut ret = 0
  if engine.gameData.stage == stage_idle {
    ret = engine.debug("idle")
    ret = engine.watchInput()
  } else if engine.gameData.stage == stage_merge {
    ret = engine.debug("merge")
    ret = engine.cellArray.moveEnd()
    ret = engine.cellArray.resetRemove(0)
    ret = engine.cellArray.fillCellFirst()
    engine.gameData.stage = stage_idle
  } else if engine.gameData.stage == stage_move {
    if engine.cellArray.allCellIsMoving() {
      ret = engine.debug("moving")
      ret = engine.moveStep()
    } else {
      engine.gameData.stage = stage_merge
    }
  }
  ret = engine.drawBg()
  ret = engine.renderCell()
  ret = engine.drawUI()
  return ret
}
