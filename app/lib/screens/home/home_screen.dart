import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gaia/api/surveys.dart';
import 'package:gaia/components/user_profile_button.dart';
import 'package:gaia/models/models.dart';
import 'package:gaia/screens/home/survey_list.dart';
import 'package:gaia/utils/hooks.dart';

class HomeScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final user = useCurrentUser();
    final surveyList = useState(<Survey>[]);
    final selectedItem = useState<Survey>(null);

    final refreshSurveys = () async {
      surveyList.value = await fetchSurveyList();
    };

    useAsyncEffect(refreshSurveys, []);

    final onSurveyPressed = (Survey survey) {};

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          UserProfileButton(),
        ],
      ),
      body: SurveyList(
        data: surveyList.value,
        onRefresh: refreshSurveys,
        onSurveyPressed: onSurveyPressed,
      ),
    );
  }
}
