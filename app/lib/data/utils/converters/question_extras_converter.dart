import 'dart:convert';

import 'package:moor/moor.dart';
import 'package:sage/data/models/question_extras.dart';

class QuestionExtrasConverter extends TypeConverter<QuestionExtras, String> {

  const QuestionExtrasConverter();

  @override
  QuestionExtras mapToDart(String fromDb) {
    final data = jsonDecode(fromDb);
    return QuestionExtras.fromJson(data as Map<String, dynamic>);
  }

  @override
  String mapToSql(QuestionExtras value) {
    return jsonEncode(value);
  }
}
