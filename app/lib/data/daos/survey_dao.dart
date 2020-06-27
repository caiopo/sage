import 'package:injectable/injectable.dart';
import 'package:moor/moor.dart';
import 'package:sage/data/daos/dao.dart';
import 'package:sage/data/db.dart';
import 'package:sage/data/models/question.dart';
import 'package:sage/data/models/survey.dart';

part 'survey_dao.moor.dart';

@injectable
@UseDao(tables: [Surveys, Questions])
class SurveyDao extends Dao with _$SurveyDaoMixin {
  SurveyDao(AppDatabase db) : super(db);

  Future<void> insert(SurveyWithQuestions survey) async {
    await transaction(() async {
      print(survey.survey);
      await into(surveys).insertOnConflictUpdate(survey.survey);

      for (final question in survey.questions) {
        print(question);
        await into(questions).insertOnConflictUpdate(question);
      }
    });
  }

  Stream<List<Survey>> allSurveys() {
    return select(surveys).watch();
  }
}
