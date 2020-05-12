import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sage/data/models/answer.dart';
import 'package:sage/data/models/question.dart';
import 'package:sage/data/models/survey.dart';

part 'db.g.dart';

@singleton
@UseMoor(tables: [
  Surveys,
  Questions,
  Answers,
  QuestionAnswers,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_createDatabase());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _createDatabase() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(join(dbFolder.path, 'app.db'));
    return VmDatabase(file);
  });
}
