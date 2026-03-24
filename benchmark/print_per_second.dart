import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:format/format.dart';

/// Emitter that prints the score in per second format.
class PrintPerSecondEmitter implements ScoreEmitter {
  /// Creates a new [PrintPerSecondEmitter].
  const PrintPerSecondEmitter({this.multiplier = 10});

  /// The multiplier to apply to the score.
  final int multiplier;

  @override
  void emit(String testName, double value) {
    '{:22} {:10.2f} per second.'.print(testName, 1000000 / value * multiplier);
  }
}
