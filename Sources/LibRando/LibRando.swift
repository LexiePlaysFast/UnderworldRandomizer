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

  static let weapons:         [Weapon]!         = loadFile("Weapons")
  static let guardianSpirits: [GuardianSpirit]! = loadFile("Guardian Spirits")

}

enum Nioh2: Game {

  static let name: String = "Nioh 2"

  static let soulCores:       [SoulCore]!       = loadFile("Soul Cores")
  static let guardianSpirits: [GuardianSpirit]! = loadFile("Guardian Spirits")
  static let weapons:         [Weapon]!         = loadFile("Weapons")

}
