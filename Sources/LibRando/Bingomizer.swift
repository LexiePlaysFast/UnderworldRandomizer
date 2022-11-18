public protocol Bingomizer {

  var pool: [BingoCardSquare] { get }

  func makeCard() -> BingoCard?

}

extension Bingomizer {

  func makeCard() -> BingoCard? {
    BingoCard(squares: Array(pool.shuffled().prefix(25)))
  }

}
