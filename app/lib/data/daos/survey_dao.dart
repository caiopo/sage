import 'package:injectable/injectable.dart';
import 'package:moor/moor.dart';
import 'package:sage/data/daos/dao.dart';
import 'package:sage/data/db.dart';
import 'package:sage/data/models/survey.dart';

part 'survey_dao.moor.dart';

@injectable
@UseDao(tables: [Surveys])
class SurveyDao extends Dao with _$SurveyDaoMixin {
  SurveyDao(AppDatabase db) : super(db);

  void insert(Survey survey) {}
}
