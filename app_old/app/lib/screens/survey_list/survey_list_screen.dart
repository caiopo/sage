import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gaia/components/presentational/empty_list.dart';
import 'package:gaia/components/presentational/gaia_wordmark.dart';
import 'package:gaia/components/presentational/sync_button.dart';
import 'package:gaia/components/presentational/user_profile_button.dart';
import 'package:gaia/models/models.dart';
import 'package:gaia/screens/routes.dart';
import 'package:gaia/screens/survey_list/survey_list.dart';

class SurveyListScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final surveyList = useState(<Survey>[
      Survey(
        title: 'Pesquisa de Opinião',
        questions: [
          SurveyQuestion(
            uuid: 'aaaaaaaaaaaaaaa',
            title: 'Qual sua cor preferida?',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                'Fusce venenatis ut mauris a dignissim.',
            type: QuestionType.single,
            required: true,
            extras: {
              'options': [
                'Amarelo',
                'Azul',
                'Preto',
                'Verde',
                'Vermelho',
              ]
            },
          ),
          SurveyQuestion(
            uuid: 'aaaaaaaaaaaaaaab',
            title: 'Quais comidas você gosta?',
            description: '',
            type: QuestionType.multiple,
            required: true,
            extras: {
              'options': [
                'Pizza',
                'Sushi',
                'Macarrão',
                'Salada',
              ]
            },
          ),
          SurveyQuestion(
            uuid: 'aaaaaaaaaaaaaaabc',
            title: 'Qual sua idade?',
            type: QuestionType.number,
            required: true,
            extras: {},
          ),
          SurveyQuestion(
            uuid: 'aaaaaaaaaaaaaaabcd',
            title: 'Qual seu nome?',
            type: QuestionType.text,
            required: true,
            extras: {},
          ),
        ],
      ),
      Survey(
        title: 'Donec velit turpis',
        questions: List.generate(28, (i) => SurveyQuestion()),
      ),
      Survey(
        title: 'Consectetur adipiscing elit',
        questions: List.generate(54, (i) => SurveyQuestion()),
      ),
      Survey(
        title: 'Aliquam vel euismod purus',
        questions: List.generate(32, (i) => SurveyQuestion()),
      ),
    ]);

    return Scaffold(
      appBar: AppBar(
        title: GaiaWordmark(size: 28),
        actions: <Widget>[
          SyncButton(),
          UserProfileButton(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Create Survey',
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, Routes.surveyCreate());
        },
      ),
      body: surveyList.value.isEmpty
          ? EmptyList(
              text: 'You have no surveys',
              paddingBottom: 80,
            )
          : SurveyList(
              data: surveyList.value,
              onSurveyPressed: (Survey survey) {
                Navigator.push(context, Routes.answer(survey));
              },
            ),
    );
  }
}
