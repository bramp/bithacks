import 'dart:math';

import 'package:bithacks/bithacks.dart';
import 'vm/math.dart';
import 'package:test/test.dart';

void main() {
  test('bitRank', () {
    expect(0x00.bitRank(0), -1);
    expect(0x00.bitRank(1), -1);

    expect(0x01.bitRank(0), 0); // found at 1st bit
    expect(0x01.bitRank(1), -1); // not found

    expect(0x02.bitRank(0), 1); // found at 2nd bit
    expect(0x02.bitRank(1), -1); // not found

    expect(0x03.bitRank(0), 0); // found at 2nd bit
    expect(0x03.bitRank(1), 1); // found at 1st bit
    expect(0x03.bitRank(2), -1); // not found

    expect(0x10101010.bitRank(0), 4);
    expect(0x10101010.bitRank(1), 12);
    expect(0x10101010.bitRank(2), 20);
    expect(0x10101010.bitRank(3), 28);
    expect(0x10101010.bitRank(4), -1); // not found

    // Example from comment
    expect(0x43.bitRank(0), 0); // (found at 0th index)
    expect(0x43.bitRank(1), 1); // (found at 1st index)
    expect(0x43.bitRank(2), 6); // (found at 6th index)
    expect(0x43.bitRank(3), -1); // (not found)

    expect(0xFFFFFFFF.bitRank(0), 0);
    expect(0xFFFFFFFF.bitRank(31), 31);

    // Works for > 32 bits.
    expect(0x100000000.bitRank(0), 32);

    // Works on the largest number
    expect(maxInt.bitRank(0), 0);
    expect(maxInt.bitRank(63), 63);
  });

  /// Run tests over a range of random input, to try and find any edge cases
  /// I missed.
  test('bitrank (random tests)', () {
    final rnd = Random();
    final indexes = List.generate(63, (index) => index);

    for (int i = 0; i < 100000; i++) {
      int v = 0;

      // Pick [bitCount] random bits to set.
      int bitCount = rnd.nextInt(indexes.length);
      indexes.shuffle();
      List<int> bits = indexes.sublist(0, bitCount).toList();

      // Set the bits.
      for (final bit in bits) {
        v |= 1 << bit;
      }

      expect(v.bitCount(), bitCount);

      bits.sort(); // Sort ascending

      for (int rank = 0; rank < bits.length; rank++) {
        expect(v.bitRank(rank), bits[rank],
            reason: 'bitrank(0x${v.toRadixString(16)}, $rank )');
      }
    }
  });
}
