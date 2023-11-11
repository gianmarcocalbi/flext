import 'package:flutter/material.dart';

extension FlextCoreDateTime on DateTime {
  DateTime toDate() => DateTime.utc(year, month, day);

  /// Get a new [DateTime] instance in UTC having the same time as the current
  /// date time instance.
  DateTime toUtcWithSameTime() => DateTime.utc(
        year,
        month,
        day,
        hour,
        minute,
        second,
        millisecond,
        microsecond,
      );

  bool isBetween(DateTime? from, DateTime? to) =>
      (from == null || !isBefore(from)) && (to == null || !isAfter(to));

  bool get isDate =>
      hour == 0 &&
      minute == 0 &&
      second == 0 &&
      millisecond == 0 &&
      microsecond == 0;

  /// Computes the difference between [this] [DateTime] and [other] considering
  /// the two dateTime as dates, meaning it does not take into account the time.
  int differenceBetweenDateDays(DateTime other) =>
      toDate().difference(other.toDate()).inDays;

  TimeOfDay toTimeOfDay() => TimeOfDay.fromDateTime(this);
}
