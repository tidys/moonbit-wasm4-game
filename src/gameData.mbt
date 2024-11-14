let stage_idle : Int = 0

let stage_move : Int = 1

let stage_merge : Int = 2

let stage_result : Int = 3

struct GameData {
  mut score : Int
  mut stage : Int
  mut nodeID : Int
}

fn GameData::new() -> GameData {
  return { score: 0, stage: stage_idle, nodeID: 0 }
}

fn GameData::getNodeID(self : GameData) -> Int {
  self.nodeID = self.nodeID + 1
  return self.nodeID
}

fn GameData::addScore(self : GameData, value : Int) -> Int {
  self.score = self.score + value
  return 0
}
