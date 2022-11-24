import XCTest
@testable import LibSeeded

final class SeededTests: XCTestCase {

  let generator = XorshiftRandomNumberGenerator(seed: 0x1234)

  func testRNGSequence() {
    XCTAssertEqual(generator.next(), 4965995257616)
    XCTAssertEqual(generator.next(), 4939741737890553646)
    XCTAssertEqual(generator.next(), 5383602001768829584)
    XCTAssertEqual(generator.next(), 16429456344908623925)
    XCTAssertEqual(generator.next(), 16004688347663858837)
  }

  func testRNGRepeatable() {
    XCTAssertEqual(generator.next(), 4965995257616)
    XCTAssertEqual(generator.next(), 4939741737890553646)
    XCTAssertEqual(generator.next(), 5383602001768829584)
    XCTAssertEqual(generator.next(), 16429456344908623925)
    XCTAssertEqual(generator.next(), 16004688347663858837)
  }

  func testRNGSeed() {
    XCTAssertNotEqual(
      XorshiftRandomNumberGenerator(seed: 0x1234).next(),
      XorshiftRandomNumberGenerator(seed: 0x4321).next()
    )
  }

}
