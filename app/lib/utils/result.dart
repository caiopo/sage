import 'package:flutter/cupertino.dart';
import 'package:sage/utils/exceptions.dart';
import 'package:sage/utils/optional.dart';

export 'package:sage/utils/async_extensions.dart';

abstract class Result<D> {
  const factory Result.loading() = _LoadingResult<D>;

  factory Result.error(AppException error) = _ErrorResult<D>;

  // data must not be null
  factory Result.data(D data) = _DataResult<D>;

  const Result._();

  bool get isLoading => false;

  bool get hasData => false;

  bool get hasError => false;

  D get data => throw NoDataAvailable();

  AppException get error => throw NoErrorAvailable();

  Result<D2> map<D2>(D2 Function(D d) mapper);

  Future<Result<D2>> asyncMap<D2>(Future<D2> Function(D d) asyncMapper);

  void apply(void Function(D d) action) {}

  Future<void> asyncApply(Future<void> Function(D d) action) {
    return Future.value();
  }

  Optional<D> toOptional() {
    if (hasData) {
      return Optional.of(data);
    }
    return Optional.none();
  }
}

class _LoadingResult<D> extends Result<D> {
  const _LoadingResult() : super._();

  @override
  bool get isLoading => true;

  @override
  Result<D2> map<D2>(D2 Function(D d) mapper) => Result.loading();

  @override
  Future<Result<D2>> asyncMap<D2>(Future<D2> Function(D d) asyncMapper) {
    return Future.value(Result.loading());
  }
}

class _ErrorResult<D> extends Result<D> {
  final AppException error;

  _ErrorResult(this.error) : super._() {
    assert(() {
      print('$error, ${error.message}');
      return true;
    }());
  }

  @override
  bool get hasError => true;

  @override
  Result<D2> map<D2>(D2 Function(D d) mapper) => Result.error(error);

  @override
  Future<Result<D2>> asyncMap<D2>(Future<D2> Function(D d) asyncMapper) {
    return Future.value(Result.error(error));
  }
}

class _DataResult<D> extends Result<D> {
  final D data;

  _DataResult(this.data)
      : assert(data != null),
        super._();

  @override
  bool get hasData => true;

  @override
  Result<D2> map<D2>(D2 Function(D d) mapper) {
    return Result.data(mapper(data));
  }

  @override
  Future<Result<D2>> asyncMap<D2>(Future<D2> Function(D d) asyncMapper) async {
    return Result.data(await asyncMapper(data));
  }

  @override
  void apply(void Function(D d) action) {
    action(data);
  }

  @override
  Future<void> asyncApply(Future<void> Function(D d) action) async {
    return await action(data);
  }
}

class NoDataAvailable extends AppException {}

class NoErrorAvailable extends AppException {}
