public protocol Bingomizer {

  var pool: [BingoCardSquare] { get }
  var centreSpace: BingoCardSquare? { get }

  func makeCard() -> BingoCard?

}

extension Bingomizer {

  var centreSpace: BingoCardSquare? {
    nil
  }

  func makeCard() -> BingoCard? {
    var squares = Array(pool.shuffled().prefix(25))

    if let centreSpace = self.centreSpace {
      squares.insert(centreSpace, at: 12)
      squares.removeLast()
    }

    return BingoCard(squares: squares)
  }

}
