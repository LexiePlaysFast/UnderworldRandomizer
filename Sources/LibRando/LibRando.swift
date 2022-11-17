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

}

enum Nioh: Game {

  static let name: String = "Nioh"

  static let randomizers: [String: Randomizer] = [:]

}

enum Nioh2: Game {

  static let name: String = "Nioh 2"

  static let randomizers: [String: Randomizer] = [
    "Depths Randomizer": DepthsRandomizer()
  ]

}
