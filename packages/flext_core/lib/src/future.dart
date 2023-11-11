import 'dart:async';

extension FlextCoreFuture<T> on Future<T> {
  Future<T?> orNullOnError() async {
    try {
      return await this;
    } catch (_) {
      return null;
    }
  }
}
