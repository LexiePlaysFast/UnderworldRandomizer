public enum LibRando {
  public static let version = "0.0.1"

  fileprivate static let games: [String: Game.Type] = [
    Nioh.name: Nioh.self,
    Nioh2.name: Nioh2.self,
  ]

  public static func game(named name: String) -> Game.Type? {
    games[name]
  }

}

public protocol Game {

  static var name: String { get }

  static var randomizers: [String: Randomizer] { get }
  static var bingomizers: [String: Bingomizer] { get }

}

enum Nioh: Game {

  static let name: String = "Nioh"

  static let randomizers: [String: Randomizer] = [:]
  static let bingomizers: [String: Bingomizer] = [:]

}

enum Nioh2: Game {

  static let name: String = "Nioh 2"

  static let randomizers: [String: Randomizer] = [
    "Depths Randomizer": DepthsRandomizer(),
  ]

  static let bingomizers: [String: Bingomizer] = [
    "NG": NewGameBingomizer(),
  ]

}

public func Nioh2UnderworldFloorInformation(floorNumber: Int) -> (layout: String, boss: String)? {
  Nioh2
    .underworldFloors
    .first { $0.floorNumber == floorNumber }
    .map { floorData in
      (layout: floorData.floorLayout.name, boss: floorData.boss.name)
    }
}
