import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:sage/business/question_business.dart';
import 'package:sage/data/db.dart';
import 'package:sage/data/models/question.dart';
import 'package:sage/router/router.dart';
import 'package:sage/utils/collections.dart';
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

  List<Question> _questions = List.generate(
    50,
    (i) => Question(
      title: 'Question $i',
      description: 'Description $i',
      uuid: '$i',
      type: QuestionType.values.choice(),
      extras: null,
      optional: false,
    ),
  );

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
