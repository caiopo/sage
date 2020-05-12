import 'dart:math';

Iterable<List<T>> partition<T>(List<T> input, int maxSize) sync* {
  final partitions = (input.length / maxSize).ceil();

  for (int i = 0; i < partitions; i++) {
    final end = min((i + 1) * maxSize, input.length);

    yield input.sublist(i * maxSize, end);
  }
}

main() {
  final a = [1, 2, 3, 4, 5, 6, 7, 8, 9];

  print(partition(a, 5).toList());
}
