extension Nioh2 {

  class SoulCore: Codable, Equatable {
    let name: String
    let type: SpiritType
    let attunementCost: Int

    static func == (lhs: Nioh2.SoulCore, rhs: Nioh2.SoulCore) -> Bool {
      lhs.name == rhs.name
    }
  }

}
