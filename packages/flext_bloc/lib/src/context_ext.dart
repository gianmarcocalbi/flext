import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

export 'navigator_ext.dart';

extension ContextExt on BuildContext {
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

  /// Tries to read a provider ([Bloc]) from the context.
  ///
  /// If the provider is not found returns null.
  T? tryRead<T extends StateStreamableSource<Object?>>() {
    try {
      return read<T>();
    } catch (_) {
      return null;
    }
  }

  /// Provides the input [widget] with a bloc from the context.
  ///
  /// If the bloc is not in the context, returns just the widget itself.
  Widget provide<T extends StateStreamableSource<Object?>>(Widget widget) =>
      BlocProvider.value(value: read<T>(), child: widget);

  /// Provides the input [widget] with a bloc from the context.
  ///
  /// If the bloc is not in the context, returns just the widget itself.
  Widget tryProvide<T extends StateStreamableSource<Object?>>(Widget widget) {
    final provider = tryRead<T>();
    if (provider != null) {
      return BlocProvider.value(
        value: provider,
        child: widget,
      );
    }
    return widget;
  }

  void unfocus() => FocusScope.of(this).unfocus();
}
