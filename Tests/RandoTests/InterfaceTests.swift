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

  func testNioh2FloorData() {
    let impl = Nioh2UnderworldFloorInformation

    XCTAssertNil(impl(0))
    XCTAssertEqual(impl(1)?.layout, "Kurama")
    XCTAssertEqual(impl(30)?.layout, "Jurakudai")
    XCTAssertEqual(impl(61)?.boss, "Tate Eboshi")
    XCTAssertEqual(impl(108)?.boss, "Nightmare Bringer")
    XCTAssertNil(impl(109))
  }

}
