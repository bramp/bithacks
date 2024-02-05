import 'dart:math';

import 'package:bithacks/bithacks.dart';
import 'package:bithacks/src/math.dart';
import 'package:test/test.dart';

import 'util.dart';

void main() {
  test('bitCount should work should work with valid cases', () {
    expect(0x00.bitCount(), 0, reason: "0x00.bitCount()");
    expect(0x01.bitCount(), 1, reason: "0x01.bitCount()");
    expect(0x02.bitCount(), 1, reason: "0x02.bitCount()");
    expect(0x03.bitCount(), 2, reason: "0x03.bitCount()");

    expect(0x12.bitCount(), 2, reason: "0x12.bitCount()");
    expect(0x123.bitCount(), 4, reason: "0x123.bitCount()");
    expect(0x1234.bitCount(), 5, reason: "0x1234.bitCount()");
    expect(0x12345.bitCount(), 7, reason: "0x12345.bitCount()");
    expect(0x123456.bitCount(), 9, reason: "0x123456.bitCount()");
    expect(0x1234567.bitCount(), 12, reason: "0x1234567.bitCount()");
    expect(0x12345678.bitCount(), 13, reason: "0x12345678.bitCount()");
    expect(0x123456789.bitCount(), 15, reason: "0x123456789.bitCount()");
    expect(0x1234567890.bitCount(), 15, reason: "0x1234567890.bitCount()");
    expect(0x12345678901.bitCount(), 16, reason: "0x12345678901.bitCount()");
    expect(0x123456789012.bitCount(), 17, reason: "0x123456789012.bitCount()");
    expect(0x1234567890123.bitCount(), 19,
        reason: "0x1234567890123.bitCount()");
    expect(0x12345678901234.bitCount(), 20,
        reason: "0x12345678901234.bitCount()");

    // Max safe int.
    expect(maxSafeInt.bitCount(), 53, reason: "0x1FFFFFFFFFFFFF.bitCount()");
  });

  test('bitCount should throw for negative numbers', () {
    expect(() => (-1).bitCount(), throwsArgumentError,
        reason: "(-1).bitCount()");
  });

  test('bitCount >= 2^53 should work', () {
    expect(maxSafeInt.bitCount(), 53);
    expect((maxSafeInt + 1).bitCount(), 1);

    expect(maxInt.bitCount(), 63);
  }, testOn: '!js');

  test('bitCount >= 2^53 should throw throwsArgumentError on js', () {
    expect(() => (pow(2, 53) as int).bitCount(), throwsArgumentError,
        reason: "(2 ^ 53).bitCount()");
  }, testOn: 'js');

  test('bitCount should work with random input', () {
    // Test a bunch of random numbers. Just as a extra sanity check.
    final rnd = Random();

    for (int i = 0; i < 100000; i++) {
      final (v, bits) = randomBits(rnd);

      expect(v.bitCount(), bits.length, reason: "$v.bitCount()");
    }
  });
}
