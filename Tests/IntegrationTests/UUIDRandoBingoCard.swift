import XCTest
@testable import LibRando
import LibSeeded

final class BingoTests: XCTestCase {

  func testBingoCard() {
    let state = UUID(uuidString: "4A062CFB-2408-4109-A1FA-C0052796EC1B")!
    let bingomizer = LibRando.game(named: "Nioh 2")!.bingomizers["NG"]!

    var generatorA = UUIDSeededRandomGenerator(state: state)
    var generatorB = UUIDSeededRandomGenerator(state: state)

    let cardA = bingomizer.makeCard(using: &generatorA)
    let cardB = bingomizer.makeCard(using: &generatorB)

    XCTAssertEqual(cardA?.square(named: "B1")?.summary, cardB?.square(named: "B1")?.summary)
  }

}
