import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gaia/components/presentational/identicon.dart';
import 'package:gaia/models/models.dart';
import 'package:gaia/screens/survey_create/question_list.dart';
import 'package:gaia/utils/math.dart';

class SurveyStepper extends HookWidget {
  final ValueNotifier<String> title;

  SurveyStepper({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentStep = useState(0);

    final steps = buildSteps(currentStep.value);

    return Stepper(
      type: StepperType.horizontal,
      steps: steps,
      currentStep: currentStep.value,
      controlsBuilder: (context, {onStepContinue, onStepCancel}) {
        return buildControls(
          context,
          currentStep.value,
          onStepContinue,
          onStepCancel,
        );
      },
      onStepContinue: () {
        currentStep.value = clamp(currentStep.value + 1, 0, steps.length - 1);
      },
      onStepCancel: () {
        currentStep.value = clamp(currentStep.value - 1, 0, steps.length - 1);
      },
      onStepTapped: (step) {
        currentStep.value = step;
      },
    );
  }

  List<Step> buildSteps(int currentStep) {
    return [
      Step(
        title: Text('Title'),
        content: SingleChildScrollView(
          child: IdenticonTextField(
            title: title,
          ),
        ),
        isActive: currentStep == 0,
      ),
      Step(
        title: Text('Questions'),
        content: QuestionList(
          questions: List.generate(
            1,
            (i) => SurveyQuestion(
                  title: 'Aaaaaaaaaaa $i',
                ),
          ),
        ),
        isActive: currentStep == 1,
      )
    ];
  }

  Widget buildControls(BuildContext context, int currentStep,
      VoidCallback onStepContinue, VoidCallback onStepCancel) {
    if (currentStep == 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          OutlineButton(
            child: Text('NEXT'),
            onPressed: onStepContinue,
          )
        ],
      );
    }

    return Container();
  }
}

class IdenticonTextField extends HookWidget {
  final ValueNotifier<String> title;

  IdenticonTextField({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Identicon(
            title.value,
            size: 64,
          ),
          SizedBox(width: 16),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Pesquisa de Opinião",
                labelText: "Title",
              ),
              style: Theme.of(context).textTheme.subhead.copyWith(fontSize: 18),
              onChanged: (value) {
                title.value = value;
              },
            ),
          ),
        ],
      ),
    );
  }
}
