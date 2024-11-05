// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;
import 'package:sage_client/sage_client.dart' as _i10;
import 'package:sage_flutter/pages/auth_page.dart' as _i1;
import 'package:sage_flutter/pages/home_page.dart' as _i2;
import 'package:sage_flutter/pages/login_page.dart' as _i3;
import 'package:sage_flutter/pages/profile_page.dart' as _i4;
import 'package:sage_flutter/pages/splash_page.dart' as _i6;
import 'package:sage_flutter/pages/survey_form/question_form_page.dart' as _i5;
import 'package:sage_flutter/pages/survey_form/survey_form_page.dart' as _i7;

/// generated route for
/// [_i1.AuthPage]
class AuthRoute extends _i8.PageRouteInfo<void> {
  const AuthRoute({List<_i8.PageRouteInfo>? children})
      : super(
          AuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i1.AuthPage();
    },
  );
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i8.PageRouteInfo<void> {
  const HomeRoute({List<_i8.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomePage();
    },
  );
}

/// generated route for
/// [_i3.LoginPage]
class LoginRoute extends _i8.PageRouteInfo<void> {
  const LoginRoute({List<_i8.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i3.LoginPage();
    },
  );
}

/// generated route for
/// [_i4.ProfilePage]
class ProfileRoute extends _i8.PageRouteInfo<void> {
  const ProfileRoute({List<_i8.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i4.ProfilePage();
    },
  );
}

/// generated route for
/// [_i5.QuestionFormPage]
class QuestionFormRoute extends _i8.PageRouteInfo<QuestionFormRouteArgs> {
  QuestionFormRoute({
    _i9.Key? key,
    _i10.Question? question,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          QuestionFormRoute.name,
          args: QuestionFormRouteArgs(
            key: key,
            question: question,
          ),
          initialChildren: children,
        );

  static const String name = 'QuestionFormRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<QuestionFormRouteArgs>(
          orElse: () => const QuestionFormRouteArgs());
      return _i5.QuestionFormPage(
        key: args.key,
        question: args.question,
      );
    },
  );
}

class QuestionFormRouteArgs {
  const QuestionFormRouteArgs({
    this.key,
    this.question,
  });

  final _i9.Key? key;

  final _i10.Question? question;

  @override
  String toString() {
    return 'QuestionFormRouteArgs{key: $key, question: $question}';
  }
}

/// generated route for
/// [_i6.SplashPage]
class SplashRoute extends _i8.PageRouteInfo<void> {
  const SplashRoute({List<_i8.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i6.SplashPage();
    },
  );
}

/// generated route for
/// [_i7.SurveyFormPage]
class SurveyFormRoute extends _i8.PageRouteInfo<SurveyFormRouteArgs> {
  SurveyFormRoute({
    _i9.Key? key,
    int? surveyId,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          SurveyFormRoute.name,
          args: SurveyFormRouteArgs(
            key: key,
            surveyId: surveyId,
          ),
          rawPathParams: {'id': surveyId},
          initialChildren: children,
        );

  static const String name = 'SurveyFormRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<SurveyFormRouteArgs>(
          orElse: () => SurveyFormRouteArgs(surveyId: pathParams.optInt('id')));
      return _i7.SurveyFormPage(
        key: args.key,
        surveyId: args.surveyId,
      );
    },
  );
}

class SurveyFormRouteArgs {
  const SurveyFormRouteArgs({
    this.key,
    this.surveyId,
  });

  final _i9.Key? key;

  final int? surveyId;

  @override
  String toString() {
    return 'SurveyFormRouteArgs{key: $key, surveyId: $surveyId}';
  }
}
