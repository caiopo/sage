import 'package:sage/utils/exceptions.dart';
import 'package:sage/utils/result.dart';
import 'package:flutter/widgets.dart';

extension Then<T> on Future<Result<T>> {
  Future<Result<U>> thenAsyncMap<U>(Future<U> Function(T t) mapper) async {
    final result = await this;
    return await result.asyncMap(mapper);
  }

  Future<void> thenApply(Future<void> Function(T t) action) async {
    final result = await this;
    await result.asyncApply(action);
  }
}

extension ToResult<T> on AsyncSnapshot<T> {
  Result<T> toResult() {
    if (this.connectionState == ConnectionState.waiting) {
      return Result.loading();
    }

    if (this.hasError) {
      return Result.error(DerivedException(this.error));
    }

    return Result.data(this.data);
  }
}
