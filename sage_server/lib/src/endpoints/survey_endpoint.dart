import 'package:sage_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class SurveyEndpoint extends Endpoint {
  Future<Survey> createSurvey(Session session, Survey newSurvey) async {
    final authInfo = await session.authenticated;
    final userId = authInfo!.userId;

    print('createSurvey $userId');

    final survey = newSurvey.copyWith(
      id: null,
      ownerId: userId,
      owner: null,
      questions: newSurvey.questions.map(_cleanupQuestion).toList(),
    );

    return await Survey.db.insertRow(session, survey);
  }

  Future<List<Survey>> listSurveys(Session session) async {
    final authInfo = await session.authenticated;
    final userId = authInfo!.userId;

    print('listSurveys $userId');

    return await Survey.db.find(
      session,
      where: (s) => s.ownerId.equals(userId),
    );
  }
}

Question _cleanupQuestion(Question question) {
  switch (question.type) {
    case QuestionType.single:
    case QuestionType.multi:
      _ensureOptions(question);
      return question.copyWith(
        minLength: null,
        maxLength: null,
        minValue: null,
        maxValue: null,
      );

    case QuestionType.text:
      return question.copyWith(
        options: null,
        minValue: null,
        maxValue: null,
      );

    case QuestionType.number:
      return question.copyWith(
        options: null,
        minLength: null,
        maxLength: null,
      );
  }
}

void _ensureOptions(Question question) {
  final options = question.options;

  if (options == null || options.length < 2) {
    throw SurveyCreateError(
      message:
          "Question of type 'Single' or 'Multi' must have at least 2 options",
    );
  }
}
