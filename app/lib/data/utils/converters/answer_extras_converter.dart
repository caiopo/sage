import 'dart:convert';

import 'package:moor/moor.dart';
import 'package:sage/data/models/answer_extras.dart';

class AnswerExtrasConverter extends TypeConverter<AnswerExtras, String> {
  const AnswerExtrasConverter();

  @override
  AnswerExtras mapToDart(String fromDb) {
    final data = jsonDecode(fromDb);
    return AnswerExtras.fromJson(data as Map<String, dynamic>);
  }

  @override
  String mapToSql(AnswerExtras value) {
    return jsonEncode(value);
  }
}
