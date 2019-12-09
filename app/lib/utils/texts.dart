import 'package:gaia/models/models.dart';

String questionTypeText(QuestionType type) {
  switch (type) {
    case QuestionType.multiple:
      return 'Resposta múltipla';
    case QuestionType.single:
      return 'Resposta única';
    case QuestionType.number:
      return 'Numérica';
    case QuestionType.text:
      return 'Texto';
  }
  return null;
}
