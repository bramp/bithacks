import 'dart:math';
import 'package:bithacks/bithacks.dart';
import 'package:benchmark_harness/benchmark_harness.dart';

import 'print_per_second.dart';

/// Run with `dart run benchmark/bitcount_benchmark.dart`
///
/// On my MacBook Pro 2023 M2 Pro:
/// BitCountBenchmark      44203889.03 per second.
///
class BitCountBenchmark extends BenchmarkBase {
  BitCountBenchmark()
      : super('BitCountBenchmark', emitter: const PrintPerSecondEmitter());

  final Random rnd = Random();

  // The benchmark code.
  @override
  void run() {
    int v = rnd.nextInt(1 << 32); // Largest number it supports
    v.bitCount();
  }
}

void main() {
  BitCountBenchmark().report();
}
