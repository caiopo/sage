Iterable<T> _extract<T>(dynamic data, dynamic schema) sync* {
  if (schema is Map) {
    assert(data is Map, 'data must have the same type as the schema');
    final Map map = schema;
    assert(map.length == 1, 'schema map must have exactly one entry');

    final entry = schema.entries.first;
    assert(
      (data as Map).containsKey(entry.key),
      'data does not have "${entry.key}" key',
    );

    yield* extract(data[entry.key], entry.value);
    return;
  }

  if (schema is List) {
    assert(data is List);
    final List list = schema;
    assert(list.length == 1, 'schema list must have exactly one entry');

    yield* (data as List).expand((d) => extract<T>(d, list.first));
    return;
  }

  if (schema is Function) {
    yield schema(data) as T;
    return;
  }

  assert(false, 'unrecognized schema type "${schema.runtimeType}"');
}

List<T> extract<T>(dynamic data, dynamic schema) {
  return _extract<T>(data, schema).toList();
}

T extractSingle<T>(dynamic data, dynamic schema) {
  return _extract<T>(data, schema).first;
}
