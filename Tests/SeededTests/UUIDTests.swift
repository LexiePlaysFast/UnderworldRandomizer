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

  func testUUIDReplication2() {
    let state = UUID(uuidString: "4A062CFB-2408-4109-A1FA-C0052796EC1B")!

    let generator = UUIDSeededRandomGenerator(state: state)

    XCTAssertEqual(generator.next(), 15281981801427861458)
    XCTAssertEqual(generator.next(), 7013492334305011117)
    XCTAssertEqual(generator.next(), 16184585135793272614)
    XCTAssertEqual(generator.next(), 2663763355177546312)
    XCTAssertEqual(generator.next(), 5838130130530926252)
  }

}
