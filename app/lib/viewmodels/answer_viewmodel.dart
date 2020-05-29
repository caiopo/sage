import 'package:injectable/injectable.dart';
import 'package:sage/business/answer_business.dart';
import 'package:sage/data/db.dart';
import 'package:sage/data/models/question.dart';
import 'package:sage/utils/random.dart';
import 'package:sage/viewmodels/viewmodel.dart';

@injectable
class AnswerViewModel extends ViewModel {
  final AnswerBusiness _answerBusiness;

  AnswerViewModel(this._answerBusiness);

  Survey survey = Survey(
    uuid: 'asdadsa',
    title: 'Pesquisa de Opinião',
    uploadedAnswers: 10,
    owner: 'asda',
  );

  List<Question> questions = [
    Question(
      uuid: generateUuid(),
      title: 'Qual seu cômodo preferido?',
      description: null,
      optional: false,
      type: QuestionType.single,
      extras: QuestionExtrasSingle(
        options: [
          'Quarto',
          'Cozinha',
          'Sala',
          'Garagem',
        ],
      ),
    ),
    Question(
      uuid: generateUuid(),
      title: 'Quais frutas você gosta?',
      description: null,
      optional: false,
      type: QuestionType.multi,
      extras: QuestionExtrasMulti(
        options: [
          'Maçã',
          'Banana',
          'Goiaba',
          'Pêra',
          'Melancia label grande teste',
          'Uva',
          'Uva',
          'Uva',
          'Uva',
          'Uva',
          'Uva',
          'Uva',
          'Uva',
          'Uva',
          'Uva',
        ],
      ),
    ),
    Question(
      uuid: generateUuid(),
      title: 'Qual sua cor preferida?',
      description:
          'Lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet',
      optional: true,
      type: QuestionType.single,
      extras: QuestionExtrasSingle(
        options: [
          'Azul',
          'Amarelo',
          'Vermelho',
          'Verde',
          'Preto',
        ],
      ),
    ),
    Question(
      uuid: generateUuid(),
      title: 'Qual sua idade?',
      description: null,
      type: QuestionType.numeric,
      optional: false,
      extras: QuestionExtrasNumeric(
        min: 1,
        max: 130,
      ),
    ),
    Question(
      uuid: generateUuid(),
      title: 'Qual seu nome?',
      description: null,
      type: QuestionType.text,
      optional: false,
      extras: QuestionExtrasText(
        minLength: 3,
        maxLength: 10,
      ),
    ),
  ];

  bool previousPressed = false;

  int _currentIndex = 0;

  Question get currentQuestion => questions[_currentIndex];

  bool get isFirstQuestion => _currentIndex == 0;

  bool get isLastQuestion => _currentIndex == questions.length - 1;

  Map<String, dynamic> answers = {};

  dynamic get currentAnswer => answers[currentQuestion.uuid];

  String validation;

  void setAnswer(dynamic answer) {
    assert(() {
      final question = currentQuestion;

      if (answer == null) {
        return true;
      }

      switch (question.type) {
        case QuestionType.single:
          return answer is String;

        case QuestionType.multi:
          return answer is List<String>;

        case QuestionType.numeric:
          return answer is int;

        case QuestionType.text:
          return answer is String;
      }

      return false;
    }());

    answers[currentQuestion.uuid] = answer;

    notifyListeners();
  }

  void onPrevious() {
    if (!isFirstQuestion) {
      _currentIndex--;
      previousPressed = true;
      notifyListeners();
    }
  }

  void onNext() {
    validation = _answerBusiness.validate(currentQuestion, currentAnswer);

    if (validation == null) {
      if (!isLastQuestion) {
        _currentIndex++;
        previousPressed = false;
      } else {
        finish();
      }
    }

    notifyListeners();
  }

  bool canAdvance() {
    return _answerBusiness.canAdvance(currentQuestion, currentAnswer);
  }

  void finish() {
    print(answers);
  }

  Future<void> save() async {}
}

enum QuestionAction {
  edit,
  copy,
  delete,
}

enum QuestionEvent {
  added,
  removed,
}
