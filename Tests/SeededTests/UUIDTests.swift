import XCTest
import LibSeeded

final class UUIDTests: XCTestCase {

  func testUUIDGeneration() {
    let generatorA = UUIDSeededRandomGenerator(state: UUID())
    let generatorB = UUIDSeededRandomGenerator(state: UUID())

    XCTAssertNotEqual(generatorA.next(), generatorB.next())
    XCTAssertNotEqual(generatorA.next(), generatorB.next())
    XCTAssertNotEqual(generatorA.next(), generatorB.next())
    XCTAssertNotEqual(generatorA.next(), generatorB.next())
    XCTAssertNotEqual(generatorA.next(), generatorB.next())
  }

  func testUUIDReplication() {
    let state = UUID()
    let generatorA = UUIDSeededRandomGenerator(state: state)
    let generatorB = UUIDSeededRandomGenerator(state: state)

    XCTAssertEqual(generatorA.next(), generatorB.next())
    XCTAssertEqual(generatorA.next(), generatorB.next())
    XCTAssertEqual(generatorA.next(), generatorB.next())
    XCTAssertEqual(generatorA.next(), generatorB.next())
    XCTAssertEqual(generatorA.next(), generatorB.next())
  }

}
