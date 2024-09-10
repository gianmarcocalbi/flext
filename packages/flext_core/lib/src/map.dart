extension FlextCoreMap<Key, Value> on Map<Key, Value> {
  /// Get the item by [key] if exists, otherwise returns the result of [orElse].
  Value getOr(Key key, Value Function()? orElse) => this[key] ?? orElse!();

  /// Returns the item by [key]. If it does not exist it throws a `ItemNotFound`
  /// exception.
  Value getOrThrow(Key key) => getOr(
        key,
        () => throw ArgumentError.value(
          key,
          'key',
          'Item with key $key not found.',
        ),
      )!;
}
