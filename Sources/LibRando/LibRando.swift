public enum LibRando {
  public static let version = "0.0.1"
}

import Foundation

fileprivate let decoder = JSONDecoder()

fileprivate func loadJSONFile<T>(_ resource: String, from game: String) -> [T]? where T: Decodable {
  try? Bundle.module.url(forResource: resource, withExtension: "json", subdirectory: game)
    .map { try Data(contentsOf: $0)               }
    .map { try decoder.decode([T].self, from: $0) }
}

protocol Game {

  static var name: String { get }

}

extension Game {

  static fileprivate func loadFile<T>(_ resource: String) -> [T]? where T: Decodable {
    loadJSONFile(resource, from: name)
  }

}

enum Nioh: Game {

  static let name: String = "Nioh"

  static let weapons:         [Weapon]         = loadFile("Weapons")!
  static let guardianSpirits: [GuardianSpirit] = loadFile("Guardian Spirits")!

}

enum Nioh2: Game {

  static let name: String = "Nioh 2"

  static let soulCores:        [SoulCore]        = loadFile("Soul Cores")!
  static let guardianSpirits:  [GuardianSpirit]  = loadFile("Guardian Spirits")!
  static let weapons:          [Weapon]          = loadFile("Weapons")!

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
