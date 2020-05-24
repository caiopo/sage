import 'dart:math';

import 'package:uuid/uuid.dart';

final _random = Random();

Uuid _uuid;

String generateUuid() {
  _uuid ??= Uuid();

  return _uuid.v4();
}

double randomDouble() {
  return _random.nextDouble();
}

DateTime randomMockDate() {
  final yearStart = DateTime(2020, 1, 1);
  final now = DateTime.now();

  final duration = now.difference(yearStart) * randomDouble();

  return yearStart.add(duration);
}
