import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:sage/data/db.dart';
import 'package:sage/data/models/question.dart';
import 'package:sage/viewmodels/viewmodel.dart';
import 'package:sage/utils/collections.dart';

@injectable
class SurveyCreateViewModel extends ViewModel {
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

  void performPopupAction(QuestionAction action, String uuid) {

  }

  int _indexForUuid(String uuid) {
    return _questions.indexWhere((element) => element.uuid == uuid);
  }
}


enum QuestionAction {
  edit,
  copy,
  delete,
}
