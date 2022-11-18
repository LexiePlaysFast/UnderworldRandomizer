import Foundation

public class BingoScorer {

  let rows: [IndexSet] = [
    IndexSet( 00..<05 ),
    IndexSet( 05..<10 ),
    IndexSet( 10..<15 ),
    IndexSet( 15..<20 ),
    IndexSet( 20..<25 ),
  ]

  let columns: [IndexSet] = [
    IndexSet([0, 5, 10, 15, 20]),
    IndexSet([1, 6, 11, 16, 21]),
    IndexSet([2, 7, 12, 17, 22]),
    IndexSet([3, 8, 13, 18, 23]),
    IndexSet([4, 9, 14, 19, 24]),
  ]

  let diagonals: [IndexSet] = [
    IndexSet([0, 6, 12, 18, 24]),
    IndexSet([4, 8, 12, 16, 20]),
  ]

  lazy var lines: [IndexSet] = {
    [ rows, columns, diagonals ].reduce([], +)
  }()

  let blackout: IndexSet = IndexSet(0..<25)

  public enum Rule {
    case lines(Int)
    case blackout
  }

  public enum Score {
    case complete
    case incomplete
  }

  public static var defaultScorer: BingoScorer = { BingoScorer() }()

  public func score(_ card: BingoCard, using rule: Rule) -> Score {
    switch rule {
    case .lines(let clearCount):
      let completedLines = lines
        .map(card.marked.contains)
        .reduce(0, { $0 + ($1 ? 1 : 0) })

      return completedLines >= clearCount
        ? .complete
        : .incomplete
    case .blackout:
      return card.marked == blackout
        ? .complete
        : .incomplete
    }
  }

}
