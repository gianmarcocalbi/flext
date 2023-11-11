extension FlextCoreNum on num {
  String toShortString() {
    if (abs() < 1e3) {
      return '$this';
    }

    if (abs() < 1e6) {
      return '${(this / 1e3).toStringAsFixed(1)}K';
    }

    if (abs() < 1e9) {
      return '${(this / 1e6).toStringAsFixed(1)}M';
    }

    return '${(this / 1e9).toStringAsFixed(1)}B';
  }

  bool isBetween(int? a, int? b) =>
      (a == null || this >= a) && (b == null || this <= b);
}
