import 'package:sage/data/api/serializers/serializer.dart';
import 'package:sage/data/db.dart';
import 'package:sage/data/models/question.dart';

class SurveySerializer extends Serializer<SurveyWithQuestions> {
  @override
  SurveyWithQuestions from(dynamic data) {
    final Survey survey = Survey(
      uuid: data['uuid'] as String,
      title: data['title'] as String,
      owner: '',
      uploadedAnswers: 0,
    );

    final questions = [
      for (final q in data['questions'])
        _deserializeQuestion(survey, q as Map<String, dynamic>)
    ];

    return SurveyWithQuestions(survey, questions);
  }

  @override
  dynamic to(SurveyWithQuestions obj) {
    final survey = obj.survey;
    final questions = obj.questions;

    return {
      'uuid': survey.uuid,
      'title': survey.title,
      'questions': [
        for (final q in questions) _serializeQuestion(q),
      ]
    };
  }
}

Map<String, dynamic> _serializeQuestion(Question q) {
  final extras = q.extras.toJson();
  extras.remove('type');

  return {
    'uuid': q.uuid,
    'title': q.title,
    'description': q.description,
    'type': q.type.id,
    'required': !q.optional,
    'extras': extras,
  };
}

Question _deserializeQuestion(Survey survey, Map<String, dynamic> data) {
  final extras = {
    ...(data['extras'] as Map<String, dynamic>),
    'type': data['type'],
  };

  return Question(
    uuid: data['uuid'] as String,
    title: data['title'] as String,
    description: data['description'] as String,
    optional: !((data['required'] ?? true) as bool),
    type: QuestionType.fromJson(data['type']),
    extras: QuestionExtras.fromJson(extras),
    surveyUuid: survey.uuid,
  );
}
