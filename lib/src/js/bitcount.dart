import 'package:bithacks/src/math.dart';

/// Returns the number of bits set in a 32-bit integer.
int bitCount32(int value) {
  // TODO(bramp): Test up to 2^32, to see if it actually works, otherwise
  // rename 2^31.
  // https://stackoverflow.com/questions/43122082/efficiently-count-the-number-of-bits-in-an-integer-in-javascript
  // has some inslights, I wonder if any would be faster/useful.

  // 32-bit algorithm from
  // https://graphics.stanford.edu/~seander/bithacks.html#CountBitsSetParallel
  var v = value - ((value >> 1) & 0x55555555); // reuse input as temporary
  v = (v & 0x33333333) + ((v >> 2) & 0x33333333); // temp
  return ((v + (v >> 4) & 0xF0F0F0F) * 0x1010101) >> 24; // count
}

/// Extension on [int] to provide bit counting functionality.
extension BitCountInt on int {
  /// {@macro  bithacks.bitCount}
  int bitCount() {
    final v = this;
    if (v < 0 || v > maxSafeInt) {
      throw ArgumentError.value(
        v,
        'this',
        'must be a positive integer less than 2^53 - 1',
      );
    }

    // dart2js doesn't support bit operations above 2^32. So the native
    // implementation won't work. So instead we split the value into two parts
    // and count the bits in each part.
    const split = 1 << 24;

    // Mask off the lower 24 bits.
    final lo = v & (split - 1);

    // Shift the higher bits value down by 24.
    // Use divide, because dart2js doesn't support >> when the value is greater
    // than 32 bits.
    final hi = v ~/ split;

    return bitCount32(lo) + bitCount32(hi);
  }
}
