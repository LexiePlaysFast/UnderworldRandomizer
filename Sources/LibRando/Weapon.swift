class Weapon: Codable, Equatable {

  let type: String
  let variants: [String]?

  static func == (lhs: Weapon, rhs: Weapon) -> Bool {
    lhs.type == rhs.type
  }

  var name: String {
    type
  }

  var variantNames: [String] {
    variants ?? [name]
  }

}
