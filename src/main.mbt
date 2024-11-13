let engine : Engine = Engine::new()

pub fn start() -> Int {
  // @wasm4.set_palette(1, @wasm4.rgb(0xff0000))
  let ret : Int = engine.init()
  return 0
}

fn gamePlay() -> Int {
  if engine.gameData.stage == stage_idle {
    engine.debug("idle") |> ignore
    engine.watchInput() |> ignore
  } else if engine.gameData.stage == stage_merge {
    engine.debug("merge") |> ignore
    engine.cellArray.moveEnd() |> ignore
    engine.cellArray.resetRemove(0) |> ignore
    engine.cellArray.fillCellFirst() |> ignore
    engine.gameData.stage = stage_idle
  } else if engine.gameData.stage == stage_move {
    if engine.cellArray.allCellIsMoving() {
      engine.debug("moving") |> ignore
      engine.moveStep() |> ignore
    } else {
      engine.gameData.stage = stage_merge
    }
  }
  engine.drawBg() |> ignore
  engine.renderCell() |> ignore
  engine.drawUI() |> ignore
  return 0
}

fn gameOver() -> Int {
  @wasm4.text("Game Over!", 40, 50)
  @wasm4.text("press x replay", 22, 90)
  engine.watchGameOver() |> ignore
  return 0
}

pub fn update() -> Int {
  if engine.isGameOver == 0 {
    gamePlay() |> ignore
  } else {
    gameOver() |> ignore
  }
  return 0
}
