pub fn start() -> Int {
  // @wasm4.set_palette(1, @wasm4.rgb(0xff0000))
  let ret : Int = initCell()
  return 0
}

let stage_move : Int = 0

let stage_merge : Int = 1

let stage_idle : Int = 2

let gameData : GameData = { stage: stage_idle, score: 0 }

fn drawUI() -> Int {
  @wasm4.set_draw_colors(index=1, 4)
  gameData.score = gameData.score
  @wasm4.text("Score:" + gameData.score.to_string(), 2, 2)
  return 0
}

// 绘制格子
fn drawCell(cell : Cell) -> Int {
  @wasm4.set_draw_colors(index=1, 3)
  @wasm4.rect(cell.x, cell.y, cell.width, cell.height)
  @wasm4.set_draw_colors(index=1, 2)
  let mut textWidth : Int = 0
  let mut n : Int = cell.number
  let charSize : Int = 8
  while n != 0 {
    textWidth = textWidth + charSize
    n = n / 10
  }
  @wasm4.text(
    cell.number.to_string(),
    cell.x + (cell.width - textWidth) / 2,
    cell.y + (cell.height - charSize) / 2,
  )
  return 0
}

pub fn update() -> Int {
  let mut ret = 0
  if gameData.stage == stage_idle {
    ret = debug("idle")
    ret = watchInput()
  } else if gameData.stage == stage_merge {
    ret = debug("merge")
    ret = moveEnd()
    gameData.stage = stage_idle
  } else if gameData.stage == stage_move {
    ret = debug("move")
    if allCellIsMoving() {
      ret = debug("moving")
      ret = cellStep()
    } else {
      gameData.stage = stage_merge
    }
  }
  ret = renderCell()
  ret = drawUI()
  return ret
}

fn debug(text : String) -> Int {
  @wasm4.set_draw_colors(index=1, 3)
  @wasm4.text(text, 80, 2)
  return 0
}

fn watchInput() -> Int {
  let mut ret : Int = 0
  if @wasm4.get_gamepad(index=1).button_right {

  }
  if @wasm4.get_gamepad(index=1).button_left {

  }
  if @wasm4.get_gamepad(index=1).button_down {
    ret = cellDown()
    gameData.stage = stage_move
  }
  if @wasm4.get_gamepad(index=1).button_up {

  }
  return ret
}

fn renderCell() -> Int {
  let mut ret : Int = 0
  for cellLine in cellArray {
    for cell in cellLine {
      ret = drawCell(cell)
    }
  }
  return ret
}
