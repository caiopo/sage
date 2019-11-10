import 'package:flutter/material.dart';
import 'package:gaia/models/models.dart';

enum QuestionListAction {
  edit,
  move,
  delete,
}

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

        final i = index ~/ 2;

        final question = questions[i];
        return ListTile(
          key: Key(question.id.toString()),
          title: Text('${question.title}'),
          subtitle: Text('Lorem ipsum dolor sit amet'),
          trailing: _buildPopupMenu(),
          onTap: () {},
        );
      },
    );
  }

  Widget _buildPopupMenu() {
    return PopupMenuButton<QuestionListAction>(
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: Text('Edit'),
            value: QuestionListAction.edit,
          ),
          PopupMenuItem(
            child: Text('Move'),
            value: QuestionListAction.move,
          ),
          PopupMenuItem(
            child: Text('Delete'),
            value: QuestionListAction.delete,
          ),
        ];
      },
    );
  }
}
