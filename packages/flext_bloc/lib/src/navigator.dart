import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class _DefaultChild extends StatelessWidget {
  const _DefaultChild();

  @override
  Widget build(BuildContext context) =>
      const Center(child: CircularProgressIndicator());
}

extension FlextBlocNavigator on NavigatorState {
  /// Pushes a barrier on the navigation stack and provides a callback to
  /// pop the barrier in response to bloc state changes.
  ///
  /// The [trigger] callback is called after the route has been pushed to the
  /// navigation stack. Usually this callback should be used to add an event
  /// to the bloc.
  ///
  /// The [listener] callback is called when the bloc state changes. Usually
  /// this callback should be used to decide when to pop the barrier.
  /// The barrier can be popped by calling `Navigator.of(context).pop()`.
  ///
  /// The [listenWhen] callback is called to decide when the [listener]
  /// will be called and when it will be skipped. Just like the [BlocListener].
  ///
  /// [timeout] is the maximum amount of time to wait for the barrier to be
  /// popped. If the timeout is reached, the barrier will be popped
  /// automatically.
  ///
  /// [barrierColor] is the color of the barrier.
  ///
  /// [child] is the widget to be shown while the barrier is active. By default
  /// it shows a centered circular progress indicator.
  Future pushBlocListenerBarrier<B extends BlocBase<S>, S>({
    required B bloc,
    required VoidCallback trigger,
    required void Function(BuildContext context, S state) listener,
    bool Function(S previous, S current)? listenWhen,
    Duration? timeout,
    Color barrierColor = Colors.black54,
    Widget child = const _DefaultChild(),
  }) async {
    final route = PageRouteBuilder(
      pageBuilder: (_, __, ___) => PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: BlocListener<B, S>(
            bloc: bloc,
            listenWhen: listenWhen,
            listener: listener,
            child: child,
          ),
        ),
      ),
      barrierColor: barrierColor,
      barrierDismissible: false,
      fullscreenDialog: true,
      opaque: false,
      transitionDuration: Duration.zero,
    );

    // Push the route
    var future = push(route);
    if (timeout != null) {
      future = future.timeout(timeout, onTimeout: pop);
    }

    // Wait 100ms to add the event to be sure that the route has been already
    // pushed successfully before.
    await Future.delayed(const Duration(milliseconds: 100), trigger);
    return future;
  }

  /// Pushes a barrier on the navigation stack with a new [event] to be added to
  /// the bloc and provides a callback to pop the barrier in response to bloc
  /// state changes.
  ///
  /// The [trigger] callback is called after the route has been pushed to the
  /// navigation stack. Usually this callback should be used to add an event to
  /// the bloc.
  ///
  /// The [listener] callback is called when the bloc state changes. Usually
  /// this callback should be used to decide when to pop the barrier. The
  /// barrier can be popped by calling `Navigator.of(context).pop()`.
  ///
  /// The [listenWhen] callback is called to decide when the [listener] will be
  /// called and when it will be skipped. Just like the [BlocListener].
  ///
  /// [timeout] is the maximum amount of time to wait for the barrier to be
  /// popped. If the timeout is reached, the barrier will be popped
  /// automatically.
  ///
  /// [barrierColor] is the color of the barrier.
  ///
  /// [child] is the widget to be shown while the barrier is active. By default
  /// it shows a centered circular progress indicator.
  Future pushBlocListenerBarrierWithEvent<B extends Bloc<E, S>, E, S>({
    required B bloc,
    required E event,
    required void Function(BuildContext context, S state) listener,
    bool Function(S previous, S current)? listenWhen,
    Duration? timeout,
    Color barrierColor = Colors.black54,
    Widget child = const _DefaultChild(),
  }) =>
      pushBlocListenerBarrier<B, S>(
        bloc: bloc,
        trigger: () => bloc.add(event),
        listener: listener,
        listenWhen: listenWhen,
        timeout: timeout,
        barrierColor: barrierColor,
        child: child,
      );
}
