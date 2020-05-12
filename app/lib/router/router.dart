import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:sage/pages/home/home_page.dart';
import 'package:sage/pages/login/login_page.dart';

export 'package:sage/router/router.gr.dart';

@MaterialAutoRouter(
  generateNavigationHelperExtension: true,
)
class $Router {
  @initial
  LoginPage loginPage;
  HomePage homePage;
}

ExtendedNavigatorState navigator(BuildContext context) {
  return ExtendedNavigator.of(context);
}
