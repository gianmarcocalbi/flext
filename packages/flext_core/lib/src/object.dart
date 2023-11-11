extension FlextCoreObject<T> on T {
  /// Maps the current instance to another one.
  ///
  /// Useful to avoid assigning it to a temp variable and then use the variable
  /// to do a computation.
  ///
  /// ### Example
  /// To print the coordinates of the first moment of a diary.
  ///
  /// **BEFORE**
  /// ```dart
  /// final latLng = diary.unmodifiableMoments.first.moment.position.latLng;
  /// final coords = '${latLng.latitude} - ${latLng.longitude}';
  /// print(coords);
  /// ```
  ///
  /// **AFTER**
  /// ```dart
  /// final coords = diary
  ///     .unmodifiableMoments
  ///     .first
  ///     .moment
  ///     .position
  ///     .latLng
  ///     .let(
  ///       (latLng) => '${latLng.latitude} - ${latLng.longitude}',
  ///     );
  /// print(coords);
  /// ```
  O let<O>(O Function(T o) f) => f(this);
}
