extension Nioh2 {

  class Boss: Codable, Equatable {
    let name: String

    static func == (lhs: Nioh2.Boss, rhs: Nioh2.Boss) -> Bool {
      lhs.name == rhs.name
    }
  }

}
