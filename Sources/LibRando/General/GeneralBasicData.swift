struct Weapon: Codable, Equatable {

  let type: String
  let variants: [String]?

  init(type: String, variants: [String]? = nil) {
    self.type = type
    self.variants = variants
  }

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
