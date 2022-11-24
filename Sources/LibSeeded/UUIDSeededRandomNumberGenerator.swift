import Foundation

fileprivate extension UUID {

  var integers: (UInt64, UInt64) {
    var a: UInt64 = 0

    a |= UInt64(self.uuid.00) << (8 * 0)
    a |= UInt64(self.uuid.01) << (8 * 1)
    a |= UInt64(self.uuid.02) << (8 * 2)
    a |= UInt64(self.uuid.03) << (8 * 3)
    a |= UInt64(self.uuid.04) << (8 * 4)
    a |= UInt64(self.uuid.05) << (8 * 5)
    a |= UInt64(self.uuid.06) << (8 * 6)
    a |= UInt64(self.uuid.07) << (8 * 7)

    var b: UInt64 = 0

    b |= UInt64(self.uuid.08) << (8 * 0)
    b |= UInt64(self.uuid.09) << (8 * 1)
    b |= UInt64(self.uuid.10) << (8 * 2)
    b |= UInt64(self.uuid.11) << (8 * 3)
    b |= UInt64(self.uuid.12) << (8 * 4)
    b |= UInt64(self.uuid.13) << (8 * 5)
    b |= UInt64(self.uuid.14) << (8 * 6)
    b |= UInt64(self.uuid.15) << (8 * 7)

    return (a, b)
  }

}

public final class UUIDSeededRandomGenerator: RandomNumberGenerator {

  var generator: SeededRandomNumberGenerator

  public init(state: UUID) {
    let (a, b) = state.integers

    self.generator = XorshiftRandomNumberGenerator(seed: a ^ b)
  }

  public func next() -> UInt64 {
    generator.next()
  }

}
