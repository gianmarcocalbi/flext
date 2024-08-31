extension FlextIterableMapEntry<Key, Value> on Iterable<MapEntry<Key, Value>> {
  Map<Key, Value> toMap() => Map.fromEntries(this);
}
