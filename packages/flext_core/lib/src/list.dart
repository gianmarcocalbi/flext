import 'dart:math';

/// Extension methods for [List].
extension FlextCoreList<T> on List<T> {
  /// Adds [item] to the list if it is not `null`.
  void maybeAdd(T? item) {
    if (item != null) {
      add(item);
    }
  }

  /// Adds all [items] that are not `null` the list.
  void addAllNotNull(Iterable<T?> items) {
    for (final item in items) {
      maybeAdd(item);
    }
  }

  /// Returns a random element from the list.
  T pickOneRandom([Random? random]) =>
      this[(random ?? Random()).nextInt(length)];

  /// Returns a list of [amount] random elements from the list.
  List<T> pickNRandom(int amount, [Random? random]) {
    RangeError.checkValidIndex(
      amount - 1,
      this,
      'number',
      length,
      'number must be greater than 0 and less than length',
    );
    final l = toList();
    l.shuffle(random);
    return l.sublist(0, amount);
  }
}
