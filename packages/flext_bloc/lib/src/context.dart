import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

export 'navigator.dart';

extension FlextBlocBuildContext on BuildContext {
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
}
