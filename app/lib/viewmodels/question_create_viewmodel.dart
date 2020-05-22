import 'package:injectable/injectable.dart';
import 'package:sage/business/question_business.dart';
import 'package:sage/data/db.dart';
import 'package:sage/data/models/question.dart';
import 'package:sage/viewmodels/viewmodel.dart';

typedef QuestionMutator = Question Function(Question question);

@injectable
class QuestionCreateViewModel extends ViewModel {
  QuestionBusiness _questionBusiness;

  QuestionCreateViewModel(this._questionBusiness) {
    _question = _questionBusiness.create();
  }

  bool editing = false;

  Question _question;

  Question get question => _question;

  set question(Question newQuestion) {
    _question = newQuestion;
    editing = true;
    notifyListeners();
  }

  void mutateQuestion(QuestionMutator mutator) {
    _question = mutator(_question);
    notifyListeners();
  }

  void changeType(QuestionType type) {
    if (_question.type == type) return;
    _question = _question.copyWith(type: type, extras: null);
    notifyListeners();
  }
}
