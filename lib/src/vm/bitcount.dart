extension BitCountInt on int {
  /// {@template bithacks.bitCount}
  /// Counts the number of bits set to 1 in a integer. Also know as popcount.
  ///
  ///  0x00.bitCount() == 0
  ///  0x01.bitCount() == 1;
  ///  0x02.bitCount() == 1;
  ///  0x03.bitCount() == 2;
  ///  0x7FFFFFFFFFFFFFFF.bitCount() == 63;
  ///
  /// Only positive ints are supported up to 2 ^63 - 1 on native dart and 2 ^ 53
  /// - 1 with dart2js. Values outside this range will throw a ArgumentError.
  ///
  /// Uses a algorithm from https://graphics.stanford.edu/~seander/bithacks.html#CountBitsSetParallel
  /// {@endtemplate}
  int bitCount() {
    int v = this;
    if (v < 0 /* || v > 0x7FFFFFFFFFFFFFFF */) {
      throw ArgumentError.value(v, 'this', 'must be a positive integer');
    }

    // Generalised 128-bit algorithm from
    // https://graphics.stanford.edu/~seander/bithacks.html#CountBitsSetParallel
    v = v - ((v >> 1) & 0x5555555555555555);
    v = (v & 0x3333333333333333) + ((v >> 2) & 0x3333333333333333);
    v = (v + (v >> 4)) & 0x0F0F0F0F0F0F0F0F;
    return (v * 0x0101010101010101) >> 56;
  }
}
