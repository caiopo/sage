// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:sage/pages/login/login_page.dart';
import 'package:sage/pages/home/home_page.dart';
import 'package:sage/pages/sync/sync_page.dart';
import 'package:sage/pages/survey_detail/survey_detail_page.dart';
import 'package:sage/pages/survey_create/survey_create_page.dart';
import 'package:sage/pages/question_create/question_create_page.dart';
import 'package:sage/data/db.dart';
import 'package:sage/pages/answer/answer_page.dart';

abstract class Routes {
  static const login = '/';
  static const home = '/home';
  static const sync = '/sync';
  static const surveyDetail = '/survey-detail';
  static const surveyCreate = '/survey-create';
  static const questionCreate = '/question-create';
  static const answer = '/answer';
  static const all = {
    login,
    home,
    sync,
    surveyDetail,
    surveyCreate,
    questionCreate,
    answer,
  };
}

class Router extends RouterBase {
  @override
  Set<String> get allRoutes => Routes.all;

  @Deprecated('call ExtendedNavigator.ofRouter<Router>() directly')
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute<dynamic>(
          builder: (context) => LoginPage(),
          settings: settings,
        );
      case Routes.home:
        return MaterialPageRoute<dynamic>(
          builder: (context) => HomePage(),
          settings: settings,
        );
      case Routes.sync:
        return MaterialPageRoute<dynamic>(
          builder: (context) => SyncPage(),
          settings: settings,
        );
      case Routes.surveyDetail:
        if (hasInvalidArgs<SurveyDetailPageArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<SurveyDetailPageArguments>(args);
        }
        final typedArgs = args as SurveyDetailPageArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) =>
              SurveyDetailPage(surveyUuid: typedArgs.surveyUuid),
          settings: settings,
        );
      case Routes.surveyCreate:
        return MaterialPageRoute<dynamic>(
          builder: (context) => SurveyCreatePage(),
          settings: settings,
        );
      case Routes.questionCreate:
        if (hasInvalidArgs<QuestionCreatePageArguments>(args)) {
          return misTypedArgsRoute<QuestionCreatePageArguments>(args);
        }
        final typedArgs = args as QuestionCreatePageArguments ??
            QuestionCreatePageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => QuestionCreatePage(
              key: typedArgs.key,
              survey: typedArgs.survey,
              question: typedArgs.question),
          settings: settings,
        );
      case Routes.answer:
        return MaterialPageRoute<dynamic>(
          builder: (context) => AnswerPage(),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//SurveyDetailPage arguments holder class
class SurveyDetailPageArguments {
  final String surveyUuid;
  SurveyDetailPageArguments({@required this.surveyUuid});
}

//QuestionCreatePage arguments holder class
class QuestionCreatePageArguments {
  final Key key;
  final Survey survey;
  final Question question;
  QuestionCreatePageArguments({this.key, this.survey, this.question});
}

// *************************************************************************
// Navigation helper methods extension
// **************************************************************************

extension RouterNavigationHelperMethods on ExtendedNavigatorState {
  Future pushLogin() => pushNamed(Routes.login);

  Future pushHome() => pushNamed(Routes.home);

  Future pushSync() => pushNamed(Routes.sync);

  Future pushSurveyDetail({
    @required String surveyUuid,
  }) =>
      pushNamed(
        Routes.surveyDetail,
        arguments: SurveyDetailPageArguments(surveyUuid: surveyUuid),
      );

  Future pushSurveyCreate() => pushNamed(Routes.surveyCreate);

  Future pushQuestionCreate({
    Key key,
    Survey survey,
    Question question,
  }) =>
      pushNamed(
        Routes.questionCreate,
        arguments: QuestionCreatePageArguments(
            key: key, survey: survey, question: question),
      );

  Future pushAnswer() => pushNamed(Routes.answer);
}
