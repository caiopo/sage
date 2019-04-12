import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gaia/api/surveys.dart';
import 'package:gaia/components/user_profile_button.dart';
import 'package:gaia/models/models.dart';
import 'package:gaia/screens/home/survey_list.dart';
import 'package:gaia/utils/dimens.dart';
import 'package:gaia/utils/hooks.dart';

class HomeScreen extends HookWidget {
  Widget buildPhone(
    List<Survey> data,
    RefreshCallback refreshSurveys,
    OnPressedCallback<Survey> onSurveyPressed,
  ) {
    return SurveyList(
      data: data,
      onRefresh: refreshSurveys,
      onSurveyPressed: onSurveyPressed,
    );
  }

  Widget buildTablet(
    List<Survey> data,
    RefreshCallback refreshSurveys,
    OnPressedCallback<Survey> onSurveyPressed,
  ) {
    return Row(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Material(
            elevation: 4,
            child: SurveyList(
              data: data,
              onRefresh: refreshSurveys,
              onSurveyPressed: onSurveyPressed,
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: Container(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final surveyList = useState(<Survey>[]);
    final selectedItem = useState<Survey>(null);

    final refreshSurveys = () async {
      surveyList.value = await fetchSurveyList();
    };

    useAsyncEffect(refreshSurveys, []);

    final onSurveyPressed = (Survey survey) {
      selectedItem.value = survey;
    };

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          UserProfileButton(),
        ],
      ),
      body: isTablet(context)
          ? buildTablet(surveyList.value, refreshSurveys, onSurveyPressed)
          : buildPhone(surveyList.value, refreshSurveys, onSurveyPressed),
    );
  }
}
