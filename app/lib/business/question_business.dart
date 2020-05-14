import 'package:injectable/injectable.dart';
import 'package:sage/business/business.dart';
import 'package:sage/data/db.dart';
import 'package:sage/data/models/question.dart';
import 'package:sage/utils/random.dart';

@injectable
class QuestionBusiness extends Business {
  Question create({
    String title,
    String description,
    QuestionType type,
    QuestionExtras extras,
    bool optional,
  }) {
    assert(type == extras.type);

    return Question(
      uuid: generateUuid(),
      title: title,
      description: description,
      type: type,
      extras: extras,
      optional: optional,
    );
  }

  Question copy(Question question) {
    return question.copyWith(uuid: generateUuid());
  }
}
