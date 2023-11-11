extension FlextCoreList<T> on List<T> {
  void maybeAdd(T? item) {
    if (item != null) {
      add(item);
    }
  }

  void addAllNotNull(Iterable<T?> items) {
    for (final item in items) {
      maybeAdd(item);
    }
  }
}

