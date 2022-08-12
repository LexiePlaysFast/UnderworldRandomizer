public protocol EffectCard {

  var description: String { get }

}

enum EffectCardTone: String, RawRepresentable {
  case prohibited
  case required
}
