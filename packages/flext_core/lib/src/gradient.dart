import 'package:flutter/material.dart';

extension FlextCoreGradient on LinearGradient {
  static const Alignment c = Alignment.center;
  static const Alignment cl = Alignment.centerLeft;
  static const Alignment cr = Alignment.centerRight;
  static const Alignment tc = Alignment.topCenter;
  static const Alignment tl = Alignment.topLeft;
  static const Alignment tr = Alignment.topRight;
  static const Alignment bc = Alignment.bottomCenter;
  static const Alignment bl = Alignment.bottomLeft;
  static const Alignment br = Alignment.bottomRight;

  LinearGradient copyWith({
    List<Color>? colors,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    List<double>? stops,
    TileMode? tileMode,
    GradientTransform? transform,
  }) =>
      LinearGradient(
        colors: colors ?? this.colors,
        begin: begin ?? this.begin,
        end: end ?? this.end,
        stops: stops ?? this.stops,
        tileMode: tileMode ?? this.tileMode,
        transform: transform ?? this.transform,
      );

  LinearGradient copyFromTl2Br() => copyWith(begin: tl, end: br);

  LinearGradient copyFromTc2Bc() => copyWith(begin: tc, end: bc);

  LinearGradient copyFromCl2Cr() => copyWith(begin: cl, end: cr);

  LinearGradient reverse() => copyWith(colors: colors.reversed.toList());
}
