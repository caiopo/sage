import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:sage/business/question_business.dart';
import 'package:sage/data/db.dart';
import 'package:sage/data/models/question.dart';
import 'package:sage/router/router.dart';
import 'package:sage/utils/random.dart';
import 'package:sage/viewmodels/viewmodel.dart';

@injectable
class SurveyCreateViewModel extends ViewModel {
  final QuestionBusiness _questionBusiness;

  SurveyCreateViewModel(this._questionBusiness);

  String _title = '';

  String get title => _title;

  set title(String title) {
    _title = title;
    notifyListeners();
  }

  List<Question> _questions = [
    Question(
      uuid: generateUuid(),
      surveyUuid: generateUuid(),
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
      surveyUuid: generateUuid(),
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
          'Melancia label grande teste'
        ],
      ),
    ),
    Question(
      uuid: generateUuid(),
      surveyUuid: generateUuid(),
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
      surveyUuid: generateUuid(),
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
      surveyUuid: generateUuid(),
      title: 'Qual seu nome?',
      description: null,
      type: QuestionType.text,
      optional: false,
      extras: QuestionExtrasNumeric(
        min: 3,
        max: 10,
      ),
    ),
  ];

  List<Question> get questions => UnmodifiableListView(_questions);

  bool reorder(String draggedItemUuid, String newPositionUuid) {
    int draggedIndex = _indexForUuid(draggedItemUuid);
    int newIndex = _indexForUuid(newPositionUuid);

    final draggedQuestion = _questions[draggedIndex];
    _questions.removeAt(draggedIndex);
    _questions.insert(newIndex, draggedQuestion);

    notifyListeners();
    return true;
  }

  Future<void> performPopupAction(
      BuildContext context, QuestionAction action, String uuid) async {
    int selectedIndex = _indexForUuid(uuid);

    switch (action) {
      case QuestionAction.edit:
        final question = await navigator(context).pushQuestionCreate(
          question: _questions[selectedIndex],
        ) as Question;

        print(question);

        if (question != null) {
          _questions[selectedIndex] = question;
        }
        notifyListeners();
        break;

      case QuestionAction.copy:
        final newQuestion = _questionBusiness.copy(_questions[selectedIndex]);
        _questions.insert(selectedIndex + 1, newQuestion);
        notifyListeners();
        break;

      case QuestionAction.delete:
        _questions.removeAt(selectedIndex);
        notifyListeners();
        break;
    }
  }

  int _indexForUuid(String uuid) {
    return _questions.indexWhere((element) => element.uuid == uuid);
  }

  void addQuestion(Question question) {
    _questions.add(question);
    notifyListeners();
  }

  Future<void> save() async {
    print(_title);
    print(_questions.length);
  }
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
