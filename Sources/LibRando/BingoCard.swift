import Foundation

public struct BingoCard {

  public let squares: [BingoCardSquare]
  public private(set) var marked: IndexSet = IndexSet()

  public init?(squares: [BingoCardSquare]) {
    guard
      squares.count == boardSize * boardSize
    else {
      return nil
    }

    self.squares = squares
  }

  public func square(named square: String) -> BingoCardSquare? {
    guard
      let index = index(for: square)
    else {
      return nil
    }

    return squares[index]
  }

  @discardableResult
  public mutating func mark(square: String) -> Bool {
    guard
      let index = index(for: square)
    else {
      return false
    }

    return mark(index: index)
  }

  public func isMarked(square: String) -> Bool? {
    index(for: square)
      .map(marked.contains)
  }

  @discardableResult
  public mutating func mark(indices: IndexSet) -> Bool {
    guard
      indices.max() ?? 25 < 25,
      indices.min() ?? -1 >= 0
    else {
      return false
    }

    marked.formUnion(indices)

    return true
  }

  mutating func mark(index: Int) -> Bool {
    guard
      isValid(index: index)
    else {
      return false
    }

    marked.insert(index)

    return true
  }

  func isValid(index: Int) -> Bool {
    index >= 0 && index < squares.count
  }

  fileprivate let boardSize = 5
  fileprivate let BINGO = "BINGO"
  func index(for square: String) -> Int? {
    guard
      square.length == 2,
      let column = BINGO.firstIndex(of: square.first!),
      let row = Int(String(square.last!)),
      (1...boardSize).contains(row)
    else {
      return nil
    }

    return (row - 1) * boardSize + column.utf16Offset(in: BINGO)
  }

}

public protocol BingoCardSquare {

  var summary: String { get }
  var description: String { get }

}
