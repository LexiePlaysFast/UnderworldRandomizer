extension Nioh {

  class GuardianSpirit: Codable, Equatable {
    let name: String
    let element: Nioh.Element

    static func == (lhs: Nioh.GuardianSpirit, rhs: Nioh.GuardianSpirit) -> Bool {
      lhs.name == rhs.name
    }
  }

}
