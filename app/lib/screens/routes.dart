import 'package:flutter/material.dart';
import 'package:gaia/models/models.dart';
import 'package:gaia/screens/answer/answer_screen.dart';
import 'package:gaia/screens/login/login_screen.dart';
import 'package:gaia/screens/question_create/question_create_screen.dart';
import 'package:gaia/screens/survey_create/survey_create_screen.dart';
import 'package:gaia/screens/survey_detail/survey_detail_screen.dart';
import 'package:gaia/screens/survey_list/survey_list_screen.dart';
import 'package:gaia/screens/sync/sync_screen.dart';

class Routes {
  static MaterialPageRoute login() {
    return MaterialPageRoute(
      builder: (BuildContext context) => LoginScreen(),
    );
  }

  static MaterialPageRoute sync() {
    return MaterialPageRoute(
      builder: (BuildContext context) => SyncScreen(),
    );
  }

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

  static MaterialPageRoute questionCreate() {
    return MaterialPageRoute(
      builder: (BuildContext context) => QuestionCreateScreen(),
    );
  }

  static MaterialPageRoute answer(Survey survey) {
    return MaterialPageRoute(
      builder: (BuildContext context) => AnswerScreen(survey: survey),
    );
  }
}
