import 'package:flutter/material.dart';
import 'package:gaia/models/models.dart';

typedef OnPressedCallback<T> = void Function(T itemPressed);

class SurveyList extends StatelessWidget {
  final List<Survey> data;
  final RefreshCallback onRefresh;
  final OnPressedCallback<Survey> onSurveyPressed;

  const SurveyList({
    Key key,
    this.data,
    this.onRefresh,
    this.onSurveyPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: ListView.builder(
        itemBuilder: (context, i) {
          final survey = data[i];

          return ListTile(
            key: Key(survey.id.toString()),
            title: Text(survey.title),
            subtitle: Text(
                "${survey.questions.length.toString()} questions, ${survey.answers} answers"),
          );
        },
        itemCount: data?.length ?? 0,
      ),
      onRefresh: onRefresh,
      displacement: 20,
    );
  }
}
