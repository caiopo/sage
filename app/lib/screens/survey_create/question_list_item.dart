import 'package:flutter/material.dart';
import 'package:gaia/models/models.dart';

enum QuestionListAction {
  edit,
  move,
  delete,
}

class QuestionListItem extends StatelessWidget {
  final SurveyQuestion question;

  const QuestionListItem({
    Key key,
    this.question,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: Key(question.id.toString()),
      title: Text('${question.title}'),
      subtitle: Text('Lorem ipsum dolor sit amet'),
      trailing: _buildPopupMenu(),
      onTap: () {},
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
