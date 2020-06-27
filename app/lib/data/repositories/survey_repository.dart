import 'package:injectable/injectable.dart';
import 'package:sage/data/daos/survey_dao.dart';
import 'package:sage/data/db.dart';

@injectable
class SurveyRepository {
  final SurveyDao _surveyDao;

  SurveyRepository(this._surveyDao);

  Stream<List<Survey>> allSurveys() {
    return _surveyDao.allSurveys();
  }
}
