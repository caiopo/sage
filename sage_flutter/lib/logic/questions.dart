import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sage_client/sage_client.dart';

extension QuestionTypeEx on QuestionType {
  IconData get icon {
    switch (this) {
      case QuestionType.single:
        return Icons.radio_button_checked_rounded;
      case QuestionType.multi:
        return Icons.check_box_rounded;
      case QuestionType.text:
        return Icons.text_fields_rounded;
      case QuestionType.number:
        return Icons.numbers_rounded;
    }
  }

  String get label {
    switch (this) {
      case QuestionType.single:
        return 'Single choice';
      case QuestionType.multi:
        return 'Multiple choice';
      case QuestionType.text:
        return 'Text';
      case QuestionType.number:
        return 'Number';
    }
  }
}
