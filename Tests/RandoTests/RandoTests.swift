import XCTest
@testable import LibRando

final class RandoTests: XCTestCase {

  func testLibRandoVersion() {
    XCTAssertEqual(LibRando.version, "0.0.1")
  }

}
