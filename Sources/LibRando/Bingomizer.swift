public protocol Bingomizer {

  var pool: [BingoCardSquare] { get }
  var centreSpace: BingoCardSquare? { get }

  func makeCard() -> BingoCard?
  func makeCard<T: RandomNumberGenerator>(using: inout T) -> BingoCard?

}

fileprivate var defaultRandomNumberGenerator = SystemRandomNumberGenerator()

extension Bingomizer {

  var centreSpace: BingoCardSquare? {
    nil
  }

  func makeCard() -> BingoCard? {
    makeCard(using: &defaultRandomNumberGenerator)
  }

  func makeCard<T: RandomNumberGenerator>(using generator: inout T) -> BingoCard? {
    var squares = Array(pool.shuffled(using: &generator).prefix(25))

    if let centreSpace = self.centreSpace {
      squares.insert(centreSpace, at: 12)
      squares.removeLast()
    }

    return BingoCard(squares: squares)
  }

}
