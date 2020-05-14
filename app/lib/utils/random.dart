import 'package:uuid/uuid.dart';

Uuid _uuid;

String generateUuid() {
  _uuid ??= Uuid();

  return _uuid.v4();
}
