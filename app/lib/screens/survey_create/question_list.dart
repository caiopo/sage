import 'package:flutter/material.dart';
import 'package:gaia/models/models.dart';

class QuestionList extends StatelessWidget {
  final List<SurveyQuestion> questions;

  const QuestionList({
    Key key,
    this.questions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      children: questions.map((question) {
        return ListTile(
          key: Key(question.id.toString()),
          title: Text(question.title),
        );
      }).toList(),
      onReorder: (int oldIndex, int newIndex) {},
    );
  }
}