import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:sage/pages/answer/answer_page.dart';
import 'package:sage/pages/home/home_page.dart';
import 'package:sage/pages/login/login_page.dart';
import 'package:sage/pages/question_create/question_create_page.dart';
import 'package:sage/pages/survey_create/survey_create_page.dart';
import 'package:sage/pages/survey_detail/survey_detail_page.dart';
import 'package:sage/pages/sync/sync_page.dart';

export 'package:sage/router/router.gr.dart';

@MaterialAutoRouter(
  generateNavigationHelperExtension: true,
)
class $Router {
  @initial
  LoginPage login;
  HomePage home;
  SyncPage sync;

  SurveyDetailPage surveyDetail;
  SurveyCreatePage surveyCreate;
  QuestionCreatePage questionCreate;

  AnswerPage answer;
}

ExtendedNavigatorState navigator(BuildContext context) {
  return ExtendedNavigator.of(context);
}
