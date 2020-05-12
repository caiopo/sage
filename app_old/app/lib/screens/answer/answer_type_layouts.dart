import 'package:flutter/material.dart';
import 'package:gaia/models/models.dart';

typedef OnAnswerChanged = void Function(dynamic value);

class AnswerSingleChoiceQuestion extends StatelessWidget {
  final SurveyQuestion question;
  final String answer;
  final OnAnswerChanged onAnswerChanged;

  const AnswerSingleChoiceQuestion({
    Key key,
    this.question,
    this.answer,
    this.onAnswerChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final options = question.extras['options'] as List<String>;

    return Column(
      children: <Widget>[
        for (final option in options) buildOption(context, option),
      ],
    );
  }

  Widget buildOption(BuildContext context, String option) {
    return RadioListTile(
      activeColor: Theme.of(context).primaryColor,
      controlAffinity: ListTileControlAffinity.leading,
      value: option,
      groupValue: answer,
      title: Text(option),
      onChanged: (v) {
        onAnswerChanged(v);
      },
    );
  }
}

class AnswerMultipleChoiceQuestion extends StatelessWidget {
  final SurveyQuestion question;
  final List<String> answer;
  final OnAnswerChanged onAnswerChanged;

  const AnswerMultipleChoiceQuestion({
    Key key,
    this.question,
    this.answer,
    this.onAnswerChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final options = question.extras['options'] as List<String>;

    return Column(
      children: <Widget>[
        for (final option in options) buildOption(context, option),
      ],
    );
  }

  Widget buildOption(BuildContext context, String option) {
    return CheckboxListTile(
      activeColor: Theme.of(context).primaryColor,
      controlAffinity: ListTileControlAffinity.leading,
      value: answer.contains(option),
      title: Text(option),
      onChanged: (v) {
        final _answer = List.of(answer);

        if (v) {
          _answer.add(option);
        } else {
          _answer.remove(option);
        }

        onAnswerChanged(_answer);
      },
    );
  }
}

class AnswerNumberQuestion extends StatelessWidget {
  final SurveyQuestion question;
  final double answer;
  final OnAnswerChanged onAnswerChanged;

  const AnswerNumberQuestion({
    Key key,
    this.question,
    this.answer,
    this.onAnswerChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Resposta',
        ),
        autofocus: true,
        style: TextStyle(fontSize: 20),
        minLines: 1,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        onChanged: (value) {
          onAnswerChanged(double.tryParse(value));
        },
      ),
    );
  }
}

class AnswerTextQuestion extends StatelessWidget {
  final SurveyQuestion question;
  final String answer;
  final OnAnswerChanged onAnswerChanged;

  const AnswerTextQuestion({
    Key key,
    this.question,
    this.answer,
    this.onAnswerChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Resposta',
        ),
        autofocus: true,
        style: TextStyle(fontSize: 20),
        onChanged: (value) {
          onAnswerChanged(value);
        },
      ),
    );
  }
}
