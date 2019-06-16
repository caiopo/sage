import 'package:gaia/models/models.dart';

String questionTypeText(QuestionType type) {
  switch (type) {
    case QuestionType.multiple:
      return 'Multiple choice';
    case QuestionType.single:
      return 'Single choice';
    case QuestionType.number:
      return 'Number';
    case QuestionType.text:
      return 'Text';
    case QuestionType.scale:
      return 'Scale';
  }
  return null;
}
