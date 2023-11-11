import 'package:flutter/material.dart';

extension FlextCoreTimeOfDay on TimeOfDay {
  bool operator <(TimeOfDay o) =>
      hour < o.hour || (hour == o.hour && minute < o.minute);

  bool operator >(TimeOfDay o) =>
      hour > o.hour || (hour == o.hour && minute > o.minute);

  bool operator <=(TimeOfDay o) => this < o || this == o;

  bool operator >=(TimeOfDay o) => this > o || this == o;

  int compareTo(TimeOfDay other) {
    if (hour != other.hour) {
      return hour.compareTo(other.hour);
    }
    return minute.compareTo(other.minute);
  }

  DateTime toDateTime([
    int year = 0,
    int month = 1,
    int day = 1,
  ]) =>
      DateTime.utc(year, month, day, hour, minute);
}
