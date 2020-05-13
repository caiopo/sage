import 'package:flutter/material.dart';
import 'package:sage/data/models/question.dart';

class QuestionIcon extends StatelessWidget {
  final QuestionType type;

  const QuestionIcon({Key key, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(_getIconData());
  }

  IconData _getIconData() {
    switch (type) {
      case QuestionType.single:
        return Icons.radio_button_checked;

      case QuestionType.multi:
        return Icons.check_box;

      case QuestionType.numeric:
        return Icons.looks_one;

      case QuestionType.text:
        return Icons.question_answer;
    }

    return Icons.error_outline;
  }
}
