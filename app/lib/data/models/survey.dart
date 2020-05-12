import 'package:moor/moor.dart';

class Surveys extends Table {
  TextColumn get uuid => text()();

  TextColumn get title => text()();

  IntColumn get uploadedAnswers => integer()();

  @override
  Set<Column> get primaryKey => {uuid};
}
