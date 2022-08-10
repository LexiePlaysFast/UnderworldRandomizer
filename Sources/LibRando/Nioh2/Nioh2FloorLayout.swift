extension Nioh2 {

  class FloorLayout: Codable, Equatable {
    let name: String
    let scampuss: Int?
    let smallSudama: Int?
    let largeSudama: Int?
    let darkRealms: Int?

    static func == (lhs: Nioh2.FloorLayout, rhs: Nioh2.FloorLayout) -> Bool {
      lhs.name == rhs.name
    }
  }

}
