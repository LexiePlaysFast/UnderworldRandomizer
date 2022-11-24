class XorshiftRandomNumberGenerator: SeededRandomNumberGenerator {

  var state: UInt64

  required init(seed: Int) {
    self.state = UInt64(bitPattern: Int64(seed))
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
