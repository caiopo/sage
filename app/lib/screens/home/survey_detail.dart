import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gaia/models/models.dart';

class SurveyDetail extends HookWidget {
  final Survey survey;

  SurveyDetail({@required this.survey});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('oi'),
      ),
      body: Center(
        child: Text(survey.title),
      ),
    );
  }
}
