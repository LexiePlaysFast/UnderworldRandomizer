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

import Foundation

fileprivate let decoder = JSONDecoder()

fileprivate func loadJSONFile<T>(_ resource: String, from game: String) -> [T]? where T: Decodable {
  try? Bundle.module.url(forResource: resource, withExtension: "json", subdirectory: game)
    .map { try Data(contentsOf: $0)               }
    .map { try decoder.decode([T].self, from: $0) }
}

public protocol Game {

  static var name: String { get }

  static var randomizers: [String: Randomizer] { get }

}

extension Game {

  static fileprivate func loadFile<T>(_ resource: String) -> [T]? where T: Decodable {
    loadJSONFile(resource, from: name)
  }

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

  static let guardianSpirits:  [GuardianSpirit]  = loadFile("Guardian Spirits")!

  static let bosses:           [Boss]            = loadFile("Bosses")!
  static let floorLayouts:     [FloorLayout]     = loadFile("Floor Layouts")!

  static let underworldFloors: [UnderworldFloor] = loadUnderworld(bosses: bosses, floorLayouts: floorLayouts)

}

extension Nioh2 {

  static fileprivate func loadUnderworld(bosses: [Boss], floorLayouts: [FloorLayout]) -> [UnderworldFloor] {
    struct UnderworldLoader: Codable {
      let layout: String
      let boss: String
    }

    let floorLayouts: [String: FloorLayout] = floorLayouts
      .reduce(into: [:]) { dict, floorLayout in
        dict[floorLayout.name] = floorLayout
      }

    let bosses: [String: Boss] = bosses
      .reduce(into: [:]) { dict, boss in
        dict[boss.name] = boss
      }

    let loader: [UnderworldLoader] = loadFile("Underworld Floors")!

    return zip(1...loader.count, loader)
      .map { floorNumber, loader in
        UnderworldFloor(floorNumber: floorNumber, floorLayout: floorLayouts[loader.layout]!, boss: bosses[loader.boss]!)
      }
  }

}
