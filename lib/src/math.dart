export 'vm/math.dart' if (dart.library.js) 'js/math.dart';

/// Max int value that's safe with dart2js.
const int maxSafeInt = 0x1FFFFFFFFFFFFF; // 2^53 - 1
