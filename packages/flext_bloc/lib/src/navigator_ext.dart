import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension NavigatorExt on NavigatorState {
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
        pageBuilder: (_, __, ___) => WillPopScope(
          onWillPop: () async => false,
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

  Future pushBlocListenerBarrier<B extends BlocBase<S>, S>({
    required B bloc,
    required VoidCallback trigger,
    required void Function(BuildContext context, S state) listener,
    bool Function(S previous, S current)? listenWhen,
    Duration? timeout,
  }) async {
    final route = PageRouteBuilder(
      pageBuilder: (_, __, ___) => WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: BlocListener<B, S>(
            bloc: bloc,
            listenWhen: listenWhen,
            listener: listener,
            child: const Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
      barrierColor: Colors.black54,
      barrierDismissible: false,
      fullscreenDialog: true,
      opaque: false,
      transitionDuration: Duration.zero,
    );

    // Push the route
    var future = push(route);
    if (timeout != null) {
      future = future.timeout(timeout, onTimeout: () {
        pop();
      });
    }

    // Wait 100ms to add the event to be sure that the route has been already
    // pushed successfully before.
    await Future.delayed(const Duration(milliseconds: 100), trigger);
    return future;
  }

  Future pushBlocListenerBarrierWithEvent<B extends Bloc<E, S>, E, S>({
    required B bloc,
    required E event,
    required void Function(BuildContext context, S state) listener,
    bool Function(S previous, S current)? listenWhen,
    Duration? timeout,
  }) =>
      pushBlocListenerBarrier<B, S>(
        bloc: bloc,
        trigger: () => bloc.add(event),
        listener: listener,
        listenWhen: listenWhen,
        timeout: timeout,
      );

  Future pushBlocConsumerBarrier<B extends Bloc<E, S>, E, S>({
    required B bloc,
    required E event,
    required Widget Function(BuildContext context, S state) builder,
    required void Function(BuildContext context, S state) listener,
    bool Function(S previous, S current)? listenWhen,
  }) async {
    final route = PageRouteBuilder(
      pageBuilder: (_, __, ___) => WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: BlocConsumer<B, S>(
            bloc: bloc..add(event),
            listenWhen: listenWhen,
            listener: listener,
            builder: builder,
          ),
        ),
      ),
      transitionDuration: Duration.zero,
      barrierDismissible: false,
      opaque: false,
      barrierColor: Colors.black54,
    );
    // Push the route
    return push(route);
  }
}
