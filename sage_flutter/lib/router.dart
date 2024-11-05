import 'package:animations/animations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sage_flutter/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: '/splash', page: SplashRoute.page, initial: true),
        AutoRoute(path: '/auth', page: AuthRoute.page),
        AutoRoute(path: '/login', page: LoginRoute.page),
        AutoRoute(path: '/home', page: HomeRoute.page),
        AutoRoute(path: '/surveys/create', page: SurveyFormRoute.page),
        AutoRoute(path: '/surveys/:id/edit', page: SurveyFormRoute.page),
        AutoRoute(path: '/questions/edit', page: QuestionFormRoute.page),
      ];

  @override
  RouteType get defaultRouteType => RouteType.custom(
        transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) {
          return SharedAxisTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.horizontal,
            child: child,
          );
        },
      );
}
