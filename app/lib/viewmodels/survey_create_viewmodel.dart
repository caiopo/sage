import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:sage/data/db.dart';
import 'package:sage/data/models/question.dart';
import 'package:sage/viewmodels/viewmodel.dart';
import 'package:sage/utils/collections.dart';

@injectable
class SurveyCreateViewModel extends ViewModel {
  String _title;

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

  bool reorder(Key draggedItem, Key newPosition) {
    int draggedIndex = _indexForKey(draggedItem);
    int newIndex = _indexForKey(newPosition);

    final draggedQuestion = _questions[draggedIndex];
    _questions.removeAt(draggedIndex);
    _questions.insert(newIndex, draggedQuestion);

    notifyListeners();
    return true;
  }

  int _indexForKey(Key key) {
    final _key = key as ValueKey<String>;

    return _questions.indexWhere((element) => element.uuid == _key.value);
  }

//  void notifyChanged() {
//    notifyListeners();
//  }
}
