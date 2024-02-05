import 'dart:math';

import 'package:bithacks/bithacks.dart';
import 'package:bithacks/src/math.dart';
import 'package:test/test.dart';

import 'util.dart';

// Simple wrapper, to add a reason. We create a real matcher, but it didn't
// seem worth it. Either way I'm not sure I like how to the test cases look.
void expectBitRank(int v, int rank, dynamic matcher) {
  expect(v.bitRank(rank), matcher,
      reason: "0x${v.toRadixString(16)}.bitRank($rank)");
}

void main() {
  test('bitRank should work with valid cases', () {
    expectBitRank(0x00, 0, equals(-1));
    expectBitRank(0x00, 1, -1);

    expectBitRank(0x01, 0, 0); // found at 1st bit
    expectBitRank(0x01, 1, -1); // not found

    expectBitRank(0x02, 0, 1); // found at 2nd bit
    expectBitRank(0x02, 1, -1); // not found

    expectBitRank(0x03, 0, 0); // found at 1st bit
    expectBitRank(0x03, 1, 1); // found at 2nd bit
    expectBitRank(0x03, 2, -1); // not found

    expectBitRank(0x10101010, 0, 4);
    expectBitRank(0x10101010, 1, 12);
    expectBitRank(0x10101010, 2, 20);
    expectBitRank(0x10101010, 3, 28);
    expectBitRank(0x10101010, 4, -1); // not found

    // Example from comment
    expectBitRank(0x43, 0, 0); // (found at 1st index)
    expectBitRank(0x43, 1, 1); // (found at 2nd index)
    expectBitRank(0x43, 2, 6); // (found at 7th index)
    expectBitRank(0x43, 3, -1); // (not found)

    // (2^32 - 1) Has 31 bits set.
    expectBitRank(0xFFFFFFFF, 0, 0); // (found at, 1st index)
    expectBitRank(0xFFFFFFFF, 31, 31); // (found at, 32nd index)
    expectBitRank(0xFFFFFFFF, 32, -1);

    // Works for > 32 bits.
    expectBitRank(0x100000000, 0, 32);

    // 2^8 - 1
    expectBitRank(0xff, 0, 0);
    expectBitRank(0xff, 1, 1);
    expectBitRank(0xff, 2, 2);
    expectBitRank(0xff, 6, 6);
    expectBitRank(0xff, 7, 7);
    expectBitRank(0xff, 8, -1);

    // Max safe int (2 ^ 53 - 1).
    expectBitRank(maxSafeInt, 0, 0);
    expectBitRank(maxSafeInt, 51, 51);
    expectBitRank(maxSafeInt, 52, 52);
    expectBitRank(maxSafeInt, 53, -1);
  });

  test('bitRank >= 2^53 should work', () {
    // 2 ^ 53 - 1
    expectBitRank(maxSafeInt, 53, -1);

    // 2 ^ 53
    expectBitRank(0x20000000000000, 0, 53);

    // (2^63 - 1) Works on the largest number
    expectBitRank(maxInt, 0, 0); // 2^63 - 1
    expectBitRank(maxInt, 62, 62);
    expectBitRank(maxInt, 63, -1);
  }, testOn: '!js');

  test('bitRank should throw for negative numbers', () {
    expect(() => (-1).bitRank(0), throwsArgumentError,
        reason: "(-1).bitRank(0)");

    expect(() => 10.bitRank(-1), throwsArgumentError, reason: "10.bitRank(-1)");
  });

  test('bitRank should throw for large ranks', () {
    expect(() => (1).bitRank(64), throwsArgumentError,
        reason: "(1).bitRank(64)");
  }, testOn: '!js');

  test('bitRank should throw for large ranks', () {
    expect(() => (1).bitRank(54), throwsArgumentError,
        reason: "(1).bitRank(54)");
  }, testOn: 'js');

  test('bitRank should work with random input', () {
    // Test a bunch of random numbers. Just as a extra sanity check.
    final rnd = Random();

    for (int i = 0; i < 100000; i++) {
      final (v, bits) = randomBits(rnd);

      for (int i = 0; i < bits.length; i++) {
        expect(v.bitRank(i), bits[i], reason: "$v.bitRank($i)");
      }

      expect(v.bitRank(bits.length), -1, reason: "$v.bitRank($bits.length)");
    }
  });
}
