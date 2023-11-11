extension FlextCoreDouble on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));

  /// Converts a double to the equivalent ABSOLUTE value in degrees.
  ///
  /// The returned object is a tuple with three elements as
  /// `[degrees, minutes, seconds]`
  ({int degrees, int minutes, double seconds}) toDegrees() {
    final d = abs();
    var degrees = d.floor();
    final tempMinutes = d.remainder(degrees) * 60;
    var minutes =
        tempMinutes.isNaN || tempMinutes.isInfinite ? 0 : tempMinutes.floor();
    final tempSeconds = tempMinutes.remainder(minutes) * 60;
    var seconds = tempSeconds.isNaN || tempSeconds.isInfinite
        ? 0.0
        : tempMinutes.remainder(minutes) * 60;

    if (seconds == 60) {
      seconds = 0;
      minutes += 1;
    }

    if (minutes == 60) {
      minutes = 0;
      degrees += 1;
    }

    return (
      degrees: degrees,
      minutes: minutes,
      seconds: seconds,
    );
  }
}
