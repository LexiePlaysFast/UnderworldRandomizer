extension Nioh2 {

  class GuardianSpirit: Codable, Equatable {
    let name: String
    let type: SpiritType
    let attunementLimit: Int

    static func == (lhs: Nioh2.GuardianSpirit, rhs: Nioh2.GuardianSpirit) -> Bool {
      lhs.name == rhs.name
    }
  }

}
