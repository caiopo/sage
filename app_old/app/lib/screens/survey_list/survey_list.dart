import 'package:flutter/material.dart';
import 'package:gaia/components/presentational/identicon.dart';
import 'package:gaia/models/models.dart';

class SurveyList extends StatelessWidget {
  final List<Survey> data;
  final ValueChanged<Survey> onSurveyPressed;

  const SurveyList({
    Key key,
    @required this.data,
    @required this.onSurveyPressed,
  }) : super(key: key);

  Widget buildItem(Survey survey) {
    return ListTile(
      key: Key(survey.uuid),
      leading: Identicon(
        survey.title,
        size: 50,
      ),
      title: Text(survey.title),
      subtitle: Text("${survey.questions.length.toString()} perguntas"),
      onTap: () => onSurveyPressed(survey),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 80),
      itemBuilder: (context, i) {
        return buildItem(data[i]);
      },
      itemCount: data?.length ?? 0,
    );
  }
}
