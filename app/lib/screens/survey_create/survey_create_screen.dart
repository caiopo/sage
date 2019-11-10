import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gaia/screens/routes.dart';
import 'package:gaia/screens/survey_create/discard_dialog.dart';
import 'package:gaia/screens/survey_create/survey_stepper.dart';

class SurveyCreateScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final title = useState('');
    final showFab = useState(false);

    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Novo questionário'),
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
        floatingActionButton: showFab.value
            ? FloatingActionButton(
                tooltip: 'Adicionar pergunta',
                child: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(context, Routes.questionCreate());
                },
              )
            : null,
        body: SurveyStepper(
          title: title,
          onStepChanged: (step) => showFab.value = step == 1,
        ),
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
