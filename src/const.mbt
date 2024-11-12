 

struct Cell {
  mut row : Int
  mut col : Int
  mut row_target:Int;
  mut col_target:Int;
  mut dirty:Int;
  mut x : Int
  mut y : Int
  mut width : Int
  mut height : Int
  mut number : Int
}
struct GameData{
  mut score:Int;
  mut stage:Int;
}

let cellWidth : Int = 32

let cellHeight : Int = 32
