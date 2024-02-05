import '../math.dart';

extension BitRankExt on int {
  /// {@macro  bithacks.bitRank}
  int bitRank(int rank) {
    int v = this;
    if (v < 0 || v > maxSafeInt) {
      throw ArgumentError.value(
          v, 'this', 'must be a positive integer less than 2^53 - 1');
    }
    if (rank < 0 || rank > 53) {
      throw ArgumentError.value(rank, 'rank', 'must be in range [0-53]');
    }

    // Very simple loop algorithm
    // TODO Speed this up, in a similar way to vm/bitrank.dart
    int i = 0;

    // While there are bits left
    while (v > 0) {
      // Check if the lowest bit is set.
      if (v & 1 == 1) {
        // If the bit is set count it.
        if (rank <= 0) {
          return i;
        }
        rank--;
      }
      // No shift all the bits down by one.
      v = v ~/ 2; // No > 32bit safe shift in dart2js so use integer division
      i++;
    }
    return -1;
  }
}
