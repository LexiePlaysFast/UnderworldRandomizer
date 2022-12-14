public protocol Bingomizer {

  var pool: [BingoCardSquare] { get }
  var centreSpace: BingoCardSquare? { get }

  func pool<T: RandomNumberGenerator>(using: inout T) -> [BingoCardSquare]

  func makeCard() -> BingoCard?
  func makeCard<T: RandomNumberGenerator>(using: inout T) -> BingoCard?

}

fileprivate var defaultRandomNumberGenerator = SystemRandomNumberGenerator()

extension Bingomizer {

  var pool: [BingoCardSquare] {
    pool(using: &defaultRandomNumberGenerator)
  }

  var centreSpace: BingoCardSquare? {
    nil
  }

  func makeCard() -> BingoCard? {
    makeCard(using: &defaultRandomNumberGenerator)
  }

  func makeCard<T: RandomNumberGenerator>(using generator: inout T) -> BingoCard? {
    var squares = Array(pool(using: &generator).shuffled(using: &generator).prefix(25))

    if let centreSpace = self.centreSpace {
      squares.insert(centreSpace, at: 12)
      squares.removeLast()
    }

    return BingoCard(squares: squares)
  }

}
