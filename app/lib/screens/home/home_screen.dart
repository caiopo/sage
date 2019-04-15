import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gaia/api/surveys.dart';
import 'package:gaia/components/sync_button.dart';
import 'package:gaia/components/user_profile_button.dart';
import 'package:gaia/models/models.dart';
import 'package:gaia/screens/home/survey_list.dart';
import 'package:gaia/screens/routes.dart';
import 'package:gaia/utils/hooks.dart';

class HomeScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final surveyList = useState(<Survey>[]);

    final refreshSurveys = () async {
      surveyList.value = await fetchSurveyList();
    };

    useAsyncEffect(refreshSurveys, []);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          SyncButton(),
          UserProfileButton(),
        ],
      ),
      body: Stack(children: <Widget>[
        SurveyList(
          data: surveyList.value,
          onRefresh: refreshSurveys,
          onSurveyPressed: (Survey survey) {
            Navigator.push(context, Routes.surveyDetail(survey));
          },
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            tooltip: 'Create Survey',
            child: Icon(
              Icons.add,
            ),
            onPressed: () async {
              await createSurvey("Teste");
            },
          ),
        )
      ]),
    );
  }
}
