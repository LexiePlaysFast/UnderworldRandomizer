import XCTest
@testable import LibRando

final class RandoTests: XCTestCase {

  func testData() {
    XCTAssertEqual(Nioh.weapons.count, 7)
    XCTAssertEqual(Nioh.guardianSpirits.count, 29)

    XCTAssertEqual(Nioh2.soulCores.count, 75)
    XCTAssertEqual(Nioh2.guardianSpirits.count, 37)
    XCTAssertEqual(Nioh2.weapons.count, 11)

    XCTAssertEqual(Nioh2.bosses.count, 45)
    XCTAssertEqual(Nioh2.floorLayouts.count, 36)

    XCTAssertEqual(Nioh2.underworldFloors.count, 108)

    XCTAssertEqual(Nioh2.underworldFloors.first?.floorNumber, 1)
    XCTAssertEqual(Nioh2.underworldFloors.first?.boss.name, "Mezuki")
    XCTAssertEqual(Nioh2.underworldFloors.first?.floorLayout.name, "Kurama")

    XCTAssertEqual(Nioh2.underworldFloors.last?.floorNumber, 108)
    XCTAssertEqual(Nioh2.underworldFloors.last?.boss.name, "Nightmare Bringer")
    XCTAssertEqual(Nioh2.underworldFloors.last?.floorLayout.name, "Daigo Temple")
  }

  func testWeaponEffectCard() {
    let effectCard1 = WeaponCard(weapon: Nioh2.weapons.first!, tone: .required)
    let effectCard2 = WeaponCard(weapon: Nioh2.weapons.last!, tone: .prohibited)

    XCTAssertEqual(effectCard1.description, "Weapon required: Sword")
    XCTAssertEqual(effectCard2.description, "Weapon prohibited: Splitstaff")
  }

  func testDepthsRandomizer() {
    let randomizer = Nioh2.DepthsRandomizer()
    let deck = randomizer.randomize()

    deck.floors
      .map { $0.description }
      .forEach { print($0) }

    deck.spareCards!
      .map { $0.description }
      .forEach { print($0) }
  }

}
