public protocol Randomizer {

  func randomize() -> RandomizedFloors

}

public enum LogicLevel {
  case basic
  case enhanced
}

public protocol FloorEffect {

  var description: String { get }

  var cards: [EffectCard] { get }

  func validate(logicLevel: LogicLevel) -> Bool

}

public struct RandomizedFloors {

  let floors: [FloorEffect]
  let spareCards: [EffectCard]?

  init(floors: [FloorEffect], spareCards: [EffectCard]? = nil) {
    self.floors = floors
    self.spareCards = spareCards
  }

  func validate(logicLevel: LogicLevel = .basic) -> Bool {
    floors
      .map { $0.validate(logicLevel: logicLevel) }
      .allSatisfy { $0 }
  }

}
