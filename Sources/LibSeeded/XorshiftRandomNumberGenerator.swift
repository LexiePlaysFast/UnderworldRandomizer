final class XorshiftRandomNumberGenerator: SeededRandomNumberGenerator {

  var state: UInt64

  convenience init(seed: Int) {
    self.init(seed: UInt64(bitPattern: Int64(seed)))
  }

  required init(seed: UInt64) {
    self.state = seed
  }

  func next() -> UInt64 {
    var x = state

	  x ^= x << 13;
	  x ^= x >> 7;
	  x ^= x << 17;

    state = x

	  return x
  }

}
