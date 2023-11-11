import 'package:flutter/material.dart';

export 'navigator.dart';

extension FlextCoreBuildContext on BuildContext {
  /// Returns same as MediaQuery.of(context)
  MediaQueryData get mq => MediaQuery.of(this);

  /// Returns if Orientation is landscape
  bool get isLandscape => mq.orientation == Orientation.landscape;

  /// Returns same as MediaQuery.of(context).size
  Size get sizePx => mq.size;

  /// Returns same as MediaQuery.of(context).size.width
  double get widthPx => sizePx.width;

  /// Returns same as MediaQuery.of(context).height
  double get heightPx => sizePx.height;

  /// Returns same as Theme.of(context).
  ThemeData get theme => Theme.of(this);

  /// Returns same as Theme.of(context).textTheme.
  TextTheme get tt => Theme.of(this).textTheme;

  /// Returns same as Theme.of(this).colorScheme.
  ColorScheme get col => Theme.of(this).colorScheme;

  /// Returns same as Localizations.localeOf(this).
  Locale get locale => Localizations.localeOf(this);

  /// Returns same as Navigator.of(context).
  NavigatorState get nav => Navigator.of(this);

  /// Returns same as Navigator.of(context, rootNavigator: true).
  NavigatorState get navRoot => Navigator.of(this, rootNavigator: true);

  void unfocus() => FocusScope.of(this).unfocus();
}
