extension BitRankExt on int {
  /// {@template bithacks.bitRank}
  /// Finds the index of [rank]th bit set counting from the right,
  /// 0-indexed, returning -1 if no such bit exists.
  ///
  /// [rank] The rank of the bit being looked for.
  ///
  ///   7 6 5 4 3 2 1 0 (index)
  ///   0 1 0 0 0 0 1 1 (value 0x43 with 3 bits set)
  ///     2         1 0 (rank)
  ///
  ///   0x43.bitRank(0) = 0 (found at index 0)
  ///   0x43.bitRank(1) = 1 (found at index 1)
  ///   0x43.bitRank(2) = 6 (found at index 6)
  ///   0x43.bitRank(3) = -1 (not found)
  ///
  /// Only positive ints are supported up to 2 ^63 - 1 on native dart and 2 ^ 53
  /// - 1 with dart2js. Values outside this range will throw a ArgumentError.
  ///
  /// Modified from https://stackoverflow.com/q/7669057/88646
  /// and https://graphics.stanford.edu/~seander/bithacks.html##SelectPosFromMSBRank
  /// {@endtemplate}
  int bitRank(int rank) {
    final v = this;
    if (v < 0 /* || v > 0x7FFFFFFFFFFFFFFF */) {
      throw ArgumentError.value(v, 'value', 'must be a positive integer');
    }
    if (rank < 0 || rank > 63) {
      throw ArgumentError.value(rank, 'rank', 'must be in range [0-63]');
    }

    // If dart ever supports _pdep_u64 and _tzcnt_u64, then we can switch this
    // algorithm out for a faster one. e.g: https://stackoverflow.com/a/27453505/88646
    //
    // inline unsigned nthset(uint64_t x, unsigned n) {
    //    return _tzcnt_u64(_pdep_u64(1ULL << n, x));
    // }

    // Do a parallel bit count for a 64-bit integer, but store all intermediate
    // steps.

    // The constants are:
    // 0x5555555555555555  01010101010101010101010101010101  1 off, 1 on
    // 0x3333333333333333  00110011001100110011001100110011  2 off, 2 on
    // 0x0F0F0F0F0F0F0F0F  00001111000011110000111100001111  4 off, 4 on
    // 0x00FF00FF00FF00FF  00000000111111110000000011111111  8 off, 8 on
    // 0x0000FFFF0000FFFF  00000000000000001111111111111111 16 off, 16 on

    final a = (v & 0x5555555555555555) + ((v >> 1) & 0x5555555555555555);
    final b = (a & 0x3333333333333333) + ((a >> 2) & 0x3333333333333333);
    final c = (b & 0x0F0F0F0F0F0F0F0F) + ((b >> 4) & 0x0F0F0F0F0F0F0F0F);
    final d = (c & 0x00FF00FF00FF00FF) + ((c >> 8) & 0x00FF00FF00FF00FF);
    final e = (d & 0x0000FFFF0000FFFF) + ((d >> 16) & 0x0000FFFF0000FFFF);

    if (rank++ >= e) {
      return -1;
    }

    int result = 0;

    /// This is the branchless version of the code. The branched version (which
    /// isn't used, and is slower on my machine) is below. See [_bitRankBranches].
    int temp = e & 0xffff;
    result += ((temp - rank) & 256) >> 3;
    rank -= temp & ((temp - rank) >> 8);

    temp = (d >> result) & 0xff;
    result += ((temp - rank) & 256) >> 4;
    rank -= temp & ((temp - rank) >> 8);

    temp = (c >> result) & 0xff;
    result += ((temp - rank) & 256) >> 5;
    rank -= temp & ((temp - rank) >> 8);

    temp = (b >> result) & 0x0f;
    result += ((temp - rank) & 256) >> 6;
    rank -= temp & ((temp - rank) >> 8);

    temp = (a >> result) & 0x03;
    result += ((temp - rank) & 256) >> 7;
    rank -= temp & ((temp - rank) >> 8);

    temp = (v >> result) & 0x01;
    result += ((temp - rank) & 256) >> 8;

    return result;
  }

/*
  int _bitRankBranches(int rank) {
    final v = this;
    final a = (v & 0x5555555555555555) + ((v >> 1) & 0x5555555555555555);
    final b = (a & 0x3333333333333333) + ((a >> 2) & 0x3333333333333333);
    final c = (b & 0x0F0F0F0F0F0F0F0F) + ((b >> 4) & 0x0F0F0F0F0F0F0F0F);
    final d = (c & 0x00FF00FF00FF00FF) + ((c >> 8) & 0x00FF00FF00FF00FF);
    final e = (d & 0x0000FFFF0000FFFF) + ((d >> 16) & 0x0000FFFF0000FFFF);

    int result = 0;

    if (rank++ >= e) {
      return -1;
    }

    int temp;

    temp = e & 0xffff;
    if (rank > temp) {
      rank -= temp;
      result += 32;
    }

    temp = (d >> result) & 0xff;
    if (rank > temp) {
      rank -= temp;
      result += 16;
    }

    temp = (c >> result) & 0xff;
    if (rank > temp) {
      rank -= temp;
      result += 8;
    }

    temp = (b >> result) & 0x0f;
    if (rank > temp) {
      rank -= temp;
      result += 4;
    }

    temp = (a >> result) & 0x03;
    if (rank > temp) {
      rank -= temp;
      result += 2;
    }

    temp = (this >> result) & 0x01;
    if (rank > temp) result += 1;

    return result;
  }
*/
}
