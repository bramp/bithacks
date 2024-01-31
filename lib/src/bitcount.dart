extension BitCountInt on int {
  /// Counts the number of bits set to 1 in a integer. Also know as popcount.
  ///
  ///  0x00.bitCount() == 0
  ///  0x01.bitCount() == 1;
  ///  0x02.bitCount() == 1;
  ///  0x03.bitCount() == 2;
  ///  0x7FFFFFFFFFFFFFFF.bitCount() == 63;
  ///
  /// Only positive ints are supported (and this has not been tested on the web).
  ///
  /// Uses a algorithm from https://graphics.stanford.edu/~seander/bithacks.html#CountBitsSetParallel
  int bitCount() {
    int v = this;
    v = v - ((v >> 1) & 0x5555555555555555);
    v = (v & 0x3333333333333333) + ((v >> 2) & 0x3333333333333333);
    v = (v + (v >> 4)) & 0x0F0F0F0F0F0F0F0F;

    return (v * 0x0101010101010101) >> 56;
  }
}
