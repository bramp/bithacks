import 'dart:math';

import 'package:bithacks/bithacks.dart';
import 'package:bithacks/src/math.dart';

final List<int> bits = List.generate(maxIntBits, (i) => i);

/// Returns a random number, with a list of which bits which are set.
(int, List<int>) randomBits([Random? rnd]) {
  rnd ??= Random();

  /// Pick N random bits to set
  bits.shuffle(rnd);
  final setBits = bits.sublist(0, rnd.nextInt(bits.length + 1));

  int v = 0;
  for (int i = 0; i < setBits.length; i++) {
    v += pow(2, setBits[i])
        as int; // same as `v |= 1 << bits[i]` but safe on JS.
  }

  setBits.sort();

  assert(v.bitCount() == setBits.length, "$v.bitCount() != ${setBits.length}");
  return (v, setBits);
}
