# Flext Bloc

A bunch of extensions for `flutter_bloc` package.

Check out the [main Flext package](https://pub.dev/packages/flext) to see other
useful extensions.

## Getting started

Install the package by running the following command:

```bash
flutter pub add flext_bloc
```

Then you can import the package and use all its extensions.

## Features

### BuildContext

#### `tryRead`

Returns the bloc of a certain type `T` if it is available in the context,
otherwise returns `null`.

```dart
final bloc = context.tryRead<T>();
```

#### `provide`

Provides the input widget with a bloc from the context.

```dart
context.provide<T>(widget);

// Instead of
BlocProvider.value(
  value: BlocProvider.of<T>(context),
  child: widget,
);
```

#### `tryProvide`

Provides the input widget with a bloc from the context if it is available,
otherwise returns the input widget itself.

It's like `provide` but it does not throw an exception if the bloc is not found
in the context.

### Navigator

#### `pushBlocListenerBarrier`

Pushes a barrier to bloc user input while listening to a bloc in order to 
decide when to pop the barrier itself.

**NOTE: this function works also with cubits**.

```dart
// CounterBloc example here:
// https://gist.github.com/felangel/fc8230776591f0297e6a1d1b5ef46a6c#file-main-dart

context.pushBlocListenerBarrier<CounterBloc, int>(
  bloc: counterBloc,
  trigger: () => counterBloc.add(Increment())
  listener: (context, state) {
    if(state >= 1) {
      Navigator.of(context).pop();
    }
  },
);
```

#### `pushBlocListenerBarrierWithEvent`

Like `pushBlocListenerBarrier` but it takes directly a bloc event instead of a
trigger function.

```dart
context.pushBlocListenerBarrierWithEvent<CounterBloc, int>(
  bloc: counterBloc,
  event: Increment(),
  listener: (context, state) {
    if(state >= 1) {
      Navigator.of(context).pop();
    }
  },
);
```
