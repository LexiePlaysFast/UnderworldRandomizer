extension Nioh2 {

  class UnderworldFloor {

    let floorNumber: Int?
    let floorLayout: FloorLayout
    let boss: Boss

    init(floorNumber: Int, floorLayout: FloorLayout, boss: Boss) {
      self.floorNumber = floorNumber
      self.floorLayout = floorLayout
      self.boss = boss
    }

  }

}
