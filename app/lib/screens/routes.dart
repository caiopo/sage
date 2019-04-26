import 'package:flutter/material.dart';
import 'package:gaia/models/models.dart';
import 'package:gaia/screens/survey_create/survey_create_screen.dart';
import 'package:gaia/screens/survey_detail/survey_detail_screen.dart';
import 'package:gaia/screens/survey_list/survey_list_screen.dart';

class Routes {
  static MaterialPageRoute surveyList() {
    return MaterialPageRoute(
      builder: (BuildContext context) => SurveyListScreen(),
    );
  }

  static MaterialPageRoute surveyDetail(Survey survey) {
    return MaterialPageRoute(
      builder: (BuildContext context) => SurveyDetailScreen(survey: survey),
    );
  }

  static MaterialPageRoute surveyCreate() {
    return MaterialPageRoute(
      builder: (BuildContext context) => SurveyCreateScreen(),
    );
  }
}
