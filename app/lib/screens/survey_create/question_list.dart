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
    return ListView.builder(
      itemCount: questions.length * 2 - 1,
      itemBuilder: (context, index) {
        if (index % 2 != 0) {
          return Divider(height: 0);
        }

        final question = questions[index ~/ 2];
        return ListTile(
          key: Key(question.id.toString()),
          title: Text(question.title),
          subtitle: Text(question.title),
          onTap: () {},
        );
      },
    );
  }
}
