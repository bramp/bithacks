import 'dart:math';
import 'package:bithacks/bithacks.dart';
import 'package:benchmark_harness/benchmark_harness.dart';

import 'print_per_second.dart';

/// Run with `dart --observe run benchmark/bitrank_benchmark.dart`
///
/// On my MacBook Pro 2023 M2 Pro
/// BitRankBenchmark      1935790604.00 per second. (static test)
/// BitRankBenchmark        33867146.20 per second. (random test)
/// BitRankBenchmark        44371164.02 per second. (random - branchless)
///
class BitRankBenchmark extends BenchmarkBase {
  BitRankBenchmark()
      : super('BitRankBenchmark', emitter: const PrintPerSecondEmitter());

  final Random rnd = Random();

  // ignore: unused_element
  void _runStatic() {
    // Just some random bit tests
    0x10101010.bitRank(0);
    0x10101010.bitRank(1);
    0x10101010.bitRank(2);
    0x10101010.bitRank(3);
    0x10101010.bitRank(4);
  }

  // The benchmark code.
  @override
  void run() {
    int v = rnd.nextInt(1 << 32);
    int r = rnd.nextInt(32);
    v.bitRank(r);
  }
}

void main() {
  BitRankBenchmark().report();
}
