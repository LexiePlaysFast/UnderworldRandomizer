extension Nioh2 {

  enum Element: String, RawRepresentable, Codable {
    case fire
    case water
    case lightning
    case purity
    case corruption
  }

  enum SpiritType: String, RawRepresentable, Codable {
    case feral
    case brute
    case phantom
  }

}

extension Nioh2 {

  struct Boss: Codable, Equatable {
    let name: String

    static func == (lhs: Nioh2.Boss, rhs: Nioh2.Boss) -> Bool {
      lhs.name == rhs.name
    }
  }

  struct SoulCore: Codable, Equatable {
    let name: String
    let type: Nioh2.SpiritType
    let attunementCost: Int

    static func == (lhs: Nioh2.SoulCore, rhs: Nioh2.SoulCore) -> Bool {
      lhs.name == rhs.name
    }
  }

  struct FloorLayout: Codable, Equatable {
    let name: String
    let scampuss: Int?
    let smallSudama: Int?
    let largeSudama: Int?
    let darkRealms: Int?
    let majorEnemies: Int?
    let bigChests: Int?
    let hotSprings: Int?

    static func == (lhs: Nioh2.FloorLayout, rhs: Nioh2.FloorLayout) -> Bool {
      lhs.name == rhs.name
    }
  }

  struct GuardianSpirit: Codable, Equatable {
    let name: String
    let element: Nioh2.Element
    let type: Nioh2.SpiritType
    let attunementLimit: Int

    static func == (lhs: Nioh2.GuardianSpirit, rhs: Nioh2.GuardianSpirit) -> Bool {
      lhs.name == rhs.name
    }
  }

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

  struct Region {

    let name: String
    let startYear: Int?
    let endYear: Int?
    let isDLC: Bool

  }

}
