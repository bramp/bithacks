# bithacks

by Andrew Brampton ([bramp.net](https://bramp.net))

A collection of bit twiddling hacks.

[GitHub](https://github.com/bramp/bithacks) | [Package](https://pub.dev/packages/bithacks) | [API Docs](https://pub.dev/documentation/bithacks/latest/)


## Usage

```dart
  // Count the number of bits set.
  0.bitCount(); // returns 0
  1.bitCount(); // returns 1
  2.bitCount(); // returns 1
  3.bitCount(); // returns 2
  0x10101010.bitCount(); // returns 4

  // Find the position of set bits. For example:
  //
  //   7 6 5 4 3 2 1 0 (index)
  //   0 1 0 0 0 0 1 1 (value 0x43 with 3 bits set)
  //     2         1 0 (rank)
  //
  0x43.bitRank(0); // returns 0   (found at index 0)
  0x43.bitRank(1); // returns 1   (found at index 1)
  0x43.bitRank(2); // returns 6   (found at index 6)
  0x43.bitRank(3); // returns -1  (not found)
```

## Additional information

These algorithms were inspired by [Bit Twiddling Hacks](https://graphics.stanford.edu/~seander/bithacks.html)
by Sean Eron Anderson
