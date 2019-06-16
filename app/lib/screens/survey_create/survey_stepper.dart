import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gaia/components/presentational/identicon.dart';
import 'package:gaia/models/models.dart';
import 'package:gaia/screens/survey_create/question_list.dart';

const _numSteps = 2;

class SurveyStepper extends StatefulWidget {
  final ValueNotifier<String> title;
  final ValueChanged<int> onStepChanged;

  SurveyStepper({
    Key key,
    this.title,
    this.onStepChanged,
  }) : super(key: key);

  @override
  _SurveyStepperState createState() => _SurveyStepperState();
}

class _SurveyStepperState extends State<SurveyStepper> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        StepperBar(
          currentStep: currentStep,
          onStepPressed: setStep,
        ),
        Expanded(child: buildStep(currentStep)),
      ],
    );
  }

  Widget buildStep(int currentStep) {
    if (currentStep == 0) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: IdenticonTextField(
            title: widget.title,
          ),
        ),
      );
    }

    return QuestionList(
      questions: List.generate(
        100,
        (i) => SurveyQuestion(
              title: 'Lorem ipsum dolor sit amet $i',
            ),
      ),
    );
  }

  void setStep(int step) {
    setState(() {
      currentStep = step;
    });

    widget.onStepChanged(step);
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
              style: Theme.of(context).textTheme.subhead.copyWith(fontSize: 20),
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

class StepperBar extends StatelessWidget {
  final int currentStep;
  final ValueChanged<int> onStepPressed;

  const StepperBar({
    Key key,
    @required this.currentStep,
    this.onStepPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(child: buildStep(theme, 0, 'Title')),
            Expanded(child: buildStep(theme, 1, 'Questions')),
          ],
        ),
      ),
    );
  }

  Widget buildStep(ThemeData theme, int i, String title) {
    return InkWell(
      onTap: () {
        if (onStepPressed != null) {
          onStepPressed(i);
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: ShapeDecoration(
              shape: CircleBorder(),
              color:
                  currentStep == i ? theme.primaryColor : Colors.grey.shade500,
            ),
            height: 54,
            width: 24,
            child: Center(
              child: Text(
                (i + 1).toString(),
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Text(title),
        ],
      ),
    );
  }
}
