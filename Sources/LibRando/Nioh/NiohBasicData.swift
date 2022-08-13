extension Nioh {

  enum Element: String, RawRepresentable, Codable, Equatable, CaseIterable {
    case fire
    case water
    case earth
    case wind
    case lightning
  }

  class GuardianSpirit: Codable, Equatable {
    let name: String
    let element: Nioh.Element

    static func == (lhs: Nioh.GuardianSpirit, rhs: Nioh.GuardianSpirit) -> Bool {
      lhs.name == rhs.name
    }
  }

}
