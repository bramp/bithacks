// TODO Replace with a standard solution (when if one is available), see
// https://github.com/dart-lang/sdk/issues/41717
const int maxInt = 0x7FFFFFFFFFFFFFFF; // 2^63 - 1

/// Max int value that's safe with dart2js.
const int maxSafeInt = 0x1FFFFFFFFFFFFF; // 2^53 - 1
