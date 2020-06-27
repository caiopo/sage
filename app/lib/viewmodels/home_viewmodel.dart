import 'package:injectable/injectable.dart';
import 'package:sage/data/db.dart';
import 'package:sage/data/repositories/survey_repository.dart';
import 'package:sage/viewmodels/viewmodel.dart';

@injectable
class HomeViewModel extends ViewModel {
  final SurveyRepository _surveyRepository;

  HomeViewModel(this._surveyRepository);

  Stream<List<Survey>> surveys;

  void init() {
    surveys = _surveyRepository.allSurveys();
  }
}
