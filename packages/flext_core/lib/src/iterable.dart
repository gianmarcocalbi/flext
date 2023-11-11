import 'package:collection/collection.dart';

extension FlextCoreIterable<T> on Iterable<T> {
  T firstOr(T other) => firstOrNull ?? other;
  T lastOr(T other) => lastOrNull ?? other;

  Iterable<P> maybeMap<P>(P? Function(T e) toElement) => <T?>[...this]
      .map((e) => e != null ? toElement(e) : null)
      .where((e) => e != null)
      .cast<P>();
}
