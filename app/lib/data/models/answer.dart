import 'package:moor/moor.dart';
import 'package:sage/data/utils/converters/answer_extras_converter.dart';

export 'package:sage/data/models/answer_extras.dart';
export 'package:sage/data/utils/converters/answer_extras_converter.dart';

class Answers extends Table {
  TextColumn get uuid => text()();

  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();

  BoolColumn get finished => boolean().withDefault(const Constant(false))();

  TextColumn get surveyUuid =>
      text().customConstraint('REFERENCES surveys(uuid)')();

  @override
  Set<Column> get primaryKey => {uuid};
}

class QuestionAnswers extends Table {
  TextColumn get answerUuid =>
      text().customConstraint('REFERENCES answers(uuid)')();

  TextColumn get questionUuid =>
      text().customConstraint('REFERENCES questions(uuid)')();

  TextColumn get extras => text().map(const AnswerExtrasConverter())();
}
