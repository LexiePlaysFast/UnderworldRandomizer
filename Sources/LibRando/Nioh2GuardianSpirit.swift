extension Nioh2 {

  class GuardianSpirit: Codable, Equatable {
    let name: String
    let type: Nioh2.SpiritType
    let element: Nioh2.Element
    let attunementLimit: Int

    static func == (lhs: Nioh2.GuardianSpirit, rhs: Nioh2.GuardianSpirit) -> Bool {
      lhs.name == rhs.name
    }
  }

}
