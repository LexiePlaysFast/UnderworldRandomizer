import Foundation

public final class UUIDSeededRandomGenerator: RandomNumberGenerator {

  var generator: SeededRandomNumberGenerator

  public init(state: UUID) {
    self.generator = XorshiftRandomNumberGenerator(seed: state.hashValue)
  }

  public func next() -> UInt64 {
    generator.next()
  }

}

