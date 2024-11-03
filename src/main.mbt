pub fn start() -> Int {
  let sum = 0
  sum
}

pub fn update() -> Int {
  let sum = 0
  // @wasm4.set_draw_colors(0x2U, index=1)
  @wasm4.set_draw_colors(index=1, 2)
  @wasm4.rect(0, 0, 80, 40)
  sum
}
