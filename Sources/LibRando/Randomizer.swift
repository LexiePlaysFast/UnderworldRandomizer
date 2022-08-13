public protocol Randomizer {

  func randomize(logicLevel: LogicLevel) -> RandomizedFloors

}

public enum LogicLevel: String, RawRepresentable, Codable {
  case basic
  case enhanced
}

public protocol FloorEffect {

  var logicLevel: LogicLevel { get }

  var description: String { get }

  var cards: [EffectCard] { get }

  func validate(logicLevel: LogicLevel) -> Bool

}

public struct RandomizedFloors {

  let logicLevel: LogicLevel

  let floors: [FloorEffect]
  let spareCards: [EffectCard]?

  init(logicLevel: LogicLevel = .basic, floors: [FloorEffect], spareCards: [EffectCard]? = nil) {
    self.logicLevel = logicLevel
    self.floors = floors
    self.spareCards = spareCards
  }

  func validate(logicLevel: LogicLevel) -> Bool {
    logicLevel == self.logicLevel && floors.allSatisfy { $0.validate(logicLevel: logicLevel) }
  }

}
