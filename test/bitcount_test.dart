import 'dart:math';

import 'package:bithacks/bithacks.dart';
import 'package:bithacks/src/bitcount.dart';
import 'math.dart';
import 'package:test/test.dart';

// A simple bitcount algorithm by Brian Kernighan.
// https://graphics.stanford.edu/~seander/bithacks.html#CountBitsSetKernighan
int bitCountBK(int v) {
  int c = 0;
  while (v > 0) {
    v &= v - 1; // clear the least significant bit set
    c++;
  }
  return c;
}

void main() {
  test('bitCount', () {
    expect(0x00.bitCount(), 0);
    expect(0x01.bitCount(), 1);
    expect(0x02.bitCount(), 1);
    expect(0x03.bitCount(), 2);

    expect(maxInt.bitCount(), 63);
  });

  test('bitCount (comparision)', () {
    final rnd = Random();

    for (int i = 0; i < 100000; i++) {
      int v = rnd.nextInt(1 << 32); // Largest number it supports
      expect(v.bitCount(), bitCountBK(v));
    }
  });
}
