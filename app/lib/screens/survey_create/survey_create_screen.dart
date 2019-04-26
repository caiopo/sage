import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SurveyCreateScreen extends HookWidget {
  SurveyCreateScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Creating new survey'),
      ),
      body: Container(),
    );
  }
}
