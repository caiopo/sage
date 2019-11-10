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
        questions: List.generate(15, (i) => SurveyQuestion()),
        answers: 42,
      ),
      Survey(
        title: 'Donec velit turpis',
        questions: List.generate(28, (i) => SurveyQuestion()),
        answers: 80,
      ),
      Survey(
        title: 'Consectetur adipiscing elit',
        questions: List.generate(54, (i) => SurveyQuestion()),
        answers: 307,
      ),
      Survey(
        title: 'Aliquam vel euismod purus',
        questions: List.generate(32, (i) => SurveyQuestion()),
        answers: 12,
      ),
    ]);

    final refreshSurveys = () async {
//      surveyList.value = await fetchSurveyList();
    };

//    useAsyncEffect(refreshSurveys, []);

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
              onRefresh: refreshSurveys,
              onSurveyPressed: (Survey survey) {
                Navigator.push(context, Routes.surveyDetail(survey));
              },
            ),
    );
  }
}
