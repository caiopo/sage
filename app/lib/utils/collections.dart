import 'dart:math';

extension Sorting<T, K extends Comparable> on List<T> {
  void sortBy(K Function(T t) key) {
    sort((a, b) {
      final ka = key(a);
      final kb = key(b);

      assert(
        ka != null && kb != null,
        'sortBy key function should never return null',
      );

      if (ka == null && kb == null) return 0;
      if (ka == null && kb != null) return -1;
      if (ka != null && kb == null) return 1;

      return ka.compareTo(kb);
    });
  }
}

final _random = Random();

extension ListExtensions<T> on List<T> {
  bool find(bool Function(T elem) predicate) {
    for (final e in this) {
      if (predicate(e)) return true;
    }
    return false;
  }

  T choice() {
    assert(isNotEmpty);

    return this[_random.nextInt(length)];
  }

  Iterable<int> get indices sync* {
    for (int i = 0; i < this.length; i++) {
      yield i;
    }
  }
}
