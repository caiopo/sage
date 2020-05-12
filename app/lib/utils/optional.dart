import 'package:sage/utils/exceptions.dart';
import 'package:sage/utils/result.dart';

abstract class Optional<V> {
  const factory Optional.none() = _None<V>;

  factory Optional.of(V value) {
    if (value == null) return Optional.none();

    return _Value(value);
  }

  const Optional._();

  bool get hasValue => false;

  V get value => throw NoValueAvailable();

  Optional<V2> map<V2>(V2 Function(V v) mapper);

  Future<Optional<V2>> asyncMap<V2>(Future<V2> Function(V v) asyncMapper);

  V orElse(V v);

  Result<V> toResult();
}

class _None<V> extends Optional<V> {
  const _None() : super._();

  @override
  Future<Optional<V2>> asyncMap<V2>(Future<V2> Function(V v) asyncMapper) =>
      Future.value(_None());

  @override
  Optional<V2> map<V2>(V2 Function(V v) mapper) => _None();

  @override
  V orElse(V v) {
    return v;
  }

  @override
  Result<V> toResult() {
    return Result.error(ConvertedFromOptional());
  }
}

class _Value<V> extends Optional<V> {
  final V value;

  const _Value(this.value)
      : assert(value != null),
        super._();

  @override
  bool get hasValue => true;

  @override
  Future<Optional<V2>> asyncMap<V2>(
      Future<V2> Function(V v) asyncMapper) async {
    return Optional.of(await asyncMapper(value));
  }

  @override
  Optional<V2> map<V2>(V2 Function(V v) mapper) {
    return Optional.of(mapper(value));
  }

  @override
  V orElse(V v) {
    return value;
  }

  @override
  Result<V> toResult() {
    return Result.data(value);
  }
}

class NoValueAvailable extends AppException {}

class ConvertedFromOptional extends AppException {}
