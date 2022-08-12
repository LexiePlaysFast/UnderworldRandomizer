import XCTest
import LibRando

final class InterfaceTests: XCTestCase {

  func testLibRandoVersion() {
    XCTAssertEqual(LibRando.version, "0.0.1")
  }

  func testNioh2Availability() {
    let game = LibRando.game(named: "Nioh 2")

    XCTAssertNotNil(game)
    XCTAssertEqual(game?.name, "Nioh 2")
  }

}
