import XCTest
@testable import LibRando

struct TestBingoCardSquare: BingoCardSquare {

  let number: Int

  var summary: String { "\(number)" }
  let description = ""

}

final class BingoTests: XCTestCase {

  var card: BingoCard! = BingoCard(squares: (1...25).map(TestBingoCardSquare.init))

  var scorer = BingoScorer()

  func testCardSize() {
    XCTAssertNil   (BingoCard(squares: []))
    XCTAssertNil   (BingoCard(squares: (1...24).map(TestBingoCardSquare.init)))
    XCTAssertNotNil(BingoCard(squares: (1...25).map(TestBingoCardSquare.init)))
    XCTAssertNil   (BingoCard(squares: (1...26).map(TestBingoCardSquare.init)))
  }

  func testLines() {
    (0..<5)
      .forEach { _ = card.mark(index: $0) }

    XCTAssertEqual(scorer.score(card, using: .lines(1)), .complete)
    XCTAssertEqual(scorer.score(card, using: .lines(2)), .incomplete)

    [1,6,11,16,21]
      .forEach { _ = card.mark(index: $0) }

    XCTAssertEqual(scorer.score(card, using: .lines(2)), .complete)
    XCTAssertEqual(scorer.score(card, using: .lines(3)), .incomplete)

    [0,6,12,18,24]
      .forEach { _ = card.mark(index: $0) }

    XCTAssertEqual(scorer.score(card, using: .lines(3)), .complete)
    XCTAssertEqual(scorer.score(card, using: .lines(4)), .incomplete)
  }

  func testBlackout() {
    XCTAssertEqual(scorer.score(card, using: .blackout), .incomplete)

    (0..<25)
      .forEach { _ = card.mark(index: $0) }

    XCTAssertEqual(scorer.score(card, using: .blackout), .complete)
  }

  func testMark() {
    XCTAssertEqual(card.isMarked(square: "B2"), false)
    card.mark(square: "B2")
    XCTAssertEqual(card.isMarked(square: "B2"), true)

    XCTAssertNil(card.isMarked(square: "B0"))
    XCTAssertNil(card.isMarked(square: "B6"))
    XCTAssertNil(card.isMarked(square: "F4"))
  }

  func testValidation() {
    XCTAssertFalse(card.isValid(index: -1))
    XCTAssertTrue (card.isValid(index: 0))
    XCTAssertTrue (card.isValid(index: 1))
    XCTAssertTrue (card.isValid(index: 23))
    XCTAssertTrue (card.isValid(index: 24))
    XCTAssertFalse(card.isValid(index: 25))

    XCTAssertNil   (card.index(for: "F4"))

    XCTAssertNil   (card.index(for: "B0"))
    XCTAssertNotNil(card.index(for: "B4"))
    XCTAssertNil   (card.index(for: "B6"))
  }

  func testConversion() {
    XCTAssertEqual(card.index(for: "B1"), 0)
    XCTAssertEqual(card.index(for: "B2"), 5)
    XCTAssertEqual(card.index(for: "N3"), 12)
    XCTAssertEqual(card.index(for: "G5"), 23)
    XCTAssertEqual(card.index(for: "O5"), 24)
  }

  func testNamedAccess() {
    XCTAssertNil   (card.square(named: "B0"))
    XCTAssertNotNil(card.square(named: "B1"))

    XCTAssertEqual(card.square(named: "I2")?.summary, "7")
  }

  func testNGPlusBingo() {
    XCTAssertNotNil(Nioh2.NewGamePlusBingomizer().makeCard())
  }

}
