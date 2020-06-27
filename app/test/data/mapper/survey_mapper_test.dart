import 'package:flutter_test/flutter_test.dart';
import 'package:sage/data/api/serializers/survey_serializer.dart';
import 'package:sage/data/db.dart';
import 'package:sage/data/models/question.dart';

void main() {
  group('survey_mapper', () {
    test('complete survey', () {
      final mapped = SurveySerializer().to(SurveyWithQuestions(_survey, _questions));

      expect(mapped, _expected);
    });
  });
}

final _expected = {
  'uuid': '05c32d87-2afa-4901-8308-8b385b4e25f6',
  'title': 'Pesquisa de Opinião',
  'questions': [
    {
      'uuid': '25108330-b4b2-4371-9f15-a88c17a03c66',
      'title': 'Qual seu cômodo preferido?',
      'description': null,
      'type': 'single',
      'required': true,
      'extras': {
        'options': ['Quarto', 'Cozinha', 'Sala', 'Garagem']
      }
    },
    {
      'uuid': 'ac9b09fd-69e7-4af1-a143-d6e1cc5496b2',
      'title': 'Quais frutas você gosta?',
      'description': null,
      'type': 'multi',
      'required': true,
      'extras': {
        'options': [
          'Maçã',
          'Banana',
          'Goiaba',
          'Pêra',
          'Melancia label grande teste',
          'Uva',
        ]
      }
    },
    {
      'uuid': 'ce7d694d-f9ad-4333-bee7-cf341564bf3f',
      'title':
          'Qual sua cor preferida? Lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet',
      'description':
          'Lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet',
      'type': 'single',
      'required': false,
      'extras': {
        'options': ['Azul', 'Amarelo', 'Vermelho', 'Verde', 'Preto']
      }
    },
    {
      'uuid': 'b63681d1-8e1b-4974-bf82-1cfa1eec9603',
      'title': 'Qual sua idade?',
      'description': null,
      'type': 'numeric',
      'required': true,
      'extras': {'min': 1, 'max': 130}
    },
    {
      'uuid': 'a900f9b7-f9bc-4c60-b260-2e39d55e3280',
      'title': 'Qual seu nome?',
      'description': null,
      'type': 'text',
      'required': true,
      'extras': {'min_length': 3, 'max_length': 10}
    }
  ]
};

Survey _survey = Survey(
  uuid: '05c32d87-2afa-4901-8308-8b385b4e25f6',
  title: 'Pesquisa de Opinião',
  uploadedAnswers: 10,
  owner: 'owner id',
);

List<Question> _questions = [
  Question(
    uuid: '25108330-b4b2-4371-9f15-a88c17a03c66',
    surveyUuid: '05c32d87-2afa-4901-8308-8b385b4e25f6',
    title: 'Qual seu cômodo preferido?',
    description: null,
    optional: false,
    type: QuestionType.single,
    extras: QuestionExtrasSingle(
      options: [
        'Quarto',
        'Cozinha',
        'Sala',
        'Garagem',
      ],
    ),
  ),
  Question(
    uuid: 'ac9b09fd-69e7-4af1-a143-d6e1cc5496b2',
    surveyUuid: '05c32d87-2afa-4901-8308-8b385b4e25f6',
    title: 'Quais frutas você gosta?',
    description: null,
    optional: false,
    type: QuestionType.multi,
    extras: QuestionExtrasMulti(
      options: [
        'Maçã',
        'Banana',
        'Goiaba',
        'Pêra',
        'Melancia label grande teste',
        'Uva',
      ],
    ),
  ),
  Question(
    uuid: 'ce7d694d-f9ad-4333-bee7-cf341564bf3f',
    surveyUuid: '05c32d87-2afa-4901-8308-8b385b4e25f6',
    title:
        'Qual sua cor preferida? Lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet',
    description:
        'Lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet',
    optional: true,
    type: QuestionType.single,
    extras: QuestionExtrasSingle(
      options: [
        'Azul',
        'Amarelo',
        'Vermelho',
        'Verde',
        'Preto',
      ],
    ),
  ),
  Question(
    uuid: 'b63681d1-8e1b-4974-bf82-1cfa1eec9603',
    surveyUuid: '05c32d87-2afa-4901-8308-8b385b4e25f6',
    title: 'Qual sua idade?',
    description: null,
    type: QuestionType.numeric,
    optional: false,
    extras: QuestionExtrasNumeric(
      min: 1,
      max: 130,
    ),
  ),
  Question(
    uuid: 'a900f9b7-f9bc-4c60-b260-2e39d55e3280',
    surveyUuid: '05c32d87-2afa-4901-8308-8b385b4e25f6',
    title: 'Qual seu nome?',
    description: null,
    type: QuestionType.text,
    optional: false,
    extras: QuestionExtrasText(
      minLength: 3,
      maxLength: 10,
    ),
  ),
];
