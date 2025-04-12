import 'package:flutter/material.dart';

extension FlextCoreNavigator on NavigatorState {
  /// Pushes a [MaterialPageRoute] on the [this] [Navigator].
  Future<T?> pushRoute<T extends Object?>({
    required WidgetBuilder builder,
    bool fullscreenDialog = false,
  }) =>
      push<T>(
        MaterialPageRoute(
          builder: builder,
          fullscreenDialog: fullscreenDialog,
        ),
      );

  /// Pushes a barrier that cannot be dismissed by the user showing a
  /// progress indicator.
  ///
  /// The returned future should be awaited to make sure that the barrier
  /// has been successfully pushed before continuing with the logic.
  Future pushBarrier({bool showProgressIndicator = true}) async {
    push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => PopScope(
          canPop: false,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: showProgressIndicator
                ? const Center(child: CircularProgressIndicator())
                : null,
          ),
        ),
        barrierColor: Colors.black54,
        barrierDismissible: false,
        opaque: false,
        transitionDuration: Duration.zero,
      ),
    ).ignore();
    return Future.delayed(const Duration(milliseconds: 100));
  }

  /// Pushes a barrier that cannot be dismissed by the user until [future]
  /// completes.
  Future<void> pushBarrierUntil(Future Function() callback) async {
    await pushBarrier();
    try {
      await callback();
    } catch (_) {}
    pop();
  }
}
