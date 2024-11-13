let stage_idle : Int = 0

let stage_move : Int = 1

let stage_merge : Int = 2

struct GameData {
  mut score : Int
  mut stage : Int
}

fn GameData::new() -> GameData {
  return { score: 0, stage: stage_idle }
}

fn GameData::addScore(self : GameData, value : Int) -> Int {
  self.score = self.score + value
  return 0
}
