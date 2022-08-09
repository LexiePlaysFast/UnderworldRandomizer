import XCTest
@testable import LibRando

final class RandoTests: XCTestCase {

  func testLibRandoVersion() {
    XCTAssertEqual(LibRando.version, "0.0.1")
  }

  func testData() {
    XCTAssertEqual(Nioh.weapons.count, 7)
    XCTAssertEqual(Nioh.guardianSpirits.count, 29)

    XCTAssertEqual(Nioh2.soulCores.count, 75)
    XCTAssertEqual(Nioh2.guardianSpirits.count, 37)
    XCTAssertEqual(Nioh2.weapons.count, 11)
  }

}
