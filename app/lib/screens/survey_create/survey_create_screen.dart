import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gaia/screens/survey_create/discard_dialog.dart';
import 'package:gaia/screens/survey_create/survey_stepper.dart';

class SurveyCreateScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final title = useState('');

    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Creating new survey'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.check,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
        body: SurveyStepper(title: title),
      ),
      onWillPop: () async {
        final quit = await showDialog<bool>(
          context: context,
          builder: (context) => DiscardDialog(),
        );

        return quit ?? false;
      },
    );
  }
}
