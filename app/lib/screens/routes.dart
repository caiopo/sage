import 'package:flutter/material.dart';
import 'package:gaia/models/models.dart';
import 'package:gaia/screens/home/survey_detail.dart';

class Routes {
  static MaterialPageRoute surveyDetail(Survey survey) {
    return MaterialPageRoute(
      builder: (BuildContext context) => SurveyDetail(survey: survey),
    );
  }
}
