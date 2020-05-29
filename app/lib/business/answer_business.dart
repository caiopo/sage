import 'package:injectable/injectable.dart';
import 'package:sage/business/business.dart';
import 'package:sage/data/db.dart';
import 'package:sage/data/models/question.dart';

@injectable
class AnswerBusiness extends Business {
  String validate(Question question, dynamic answer) {
    if (!question.optional &&
        (answer == null ||
            (answer is List<String> && answer.isEmpty) ||
            (answer is String && answer.isEmpty))) {
      return 'Obrigatório';
    }

    if (question.type == QuestionType.numeric) {
      if (answer is String) {
        return 'Insira um número';
      }

      final value = answer as int;
      final extras = question.extras as QuestionExtrasNumeric;
      if (value < extras.min) {
        return 'O valor mínimo é ${extras.min}';
      }

      if (extras.max < value) {
        return 'O valor máximo é ${extras.max}';
      }
    }

    if (question.type == QuestionType.text) {
      final value = answer as String;
      final extras = question.extras as QuestionExtrasText;
      if (value.length < extras.minLength) {
        return 'O tamanho mínimo da resposta é ${extras.minLength}';
      }

      if (extras.maxLength < value.length) {
        return 'O tamanho máximo da resposta é ${extras.maxLength}';
      }
    }

    return null;
  }

  bool canAdvance(Question question, dynamic answer) {
    if (question.optional) return true;

    if (answer is List<String>) return answer.isNotEmpty;
    if (answer is String) return answer.isNotEmpty;

    return answer != null;
  }
}
