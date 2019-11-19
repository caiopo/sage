//import 'package:flutter/material.dart';
//import 'package:flutter_hooks/flutter_hooks.dart';
//import 'package:gaia/components/presentational/identicon.dart';
//
//class SurveyInfo extends HookWidget {
//  final ValueNotifier<String> title;
//
//  const SurveyInfo({Key key, this.title}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    useEffect(() {
//      final tabController = DefaultTabController.of(context);
//
//      final clearFocus = () {
//        FocusScope.of(context).requestFocus(FocusNode());
//      };
//
//      tabController.addListener(clearFocus);
//
//      return () => tabController.removeListener(clearFocus);
//    }, []);
//
//    return
//  }
//}
