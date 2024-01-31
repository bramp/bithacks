import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:format/format.dart';

class PrintPerSecondEmitter implements ScoreEmitter {
  final int multiplier;

  const PrintPerSecondEmitter({this.multiplier = 10});

  @override
  void emit(String testName, double value) {
    '{:22} {:10.2f} per second.'.print(testName, 1000000 / value * multiplier);
  }
}
