/// A collection of bit twiddling hacks
// TODO Add examples to this documentation.
library;

export 'src/vm/bitrank.dart' if (dart.library.js) 'src/js/bitrank.dart';
export 'src/vm/bitcount.dart' if (dart.library.js) 'src/js/bitcount.dart';
