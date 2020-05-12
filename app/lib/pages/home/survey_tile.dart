import 'package:flutter/material.dart';
import 'package:sage/data/db.dart';
import 'package:sage/router/router.dart';
import 'package:sage/widgets/identicon.dart';

class SurveyTile extends StatelessWidget {
  final Survey survey;

  const SurveyTile({
    Key key,
    @required this.survey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        survey.title,
        softWrap: false,
        overflow: TextOverflow.fade,
      ),
      subtitle: Text(
        '${survey.uploadedAnswers} respostas',
        softWrap: false,
        overflow: TextOverflow.fade,
      ),
      leading: Identicon(
        value: survey.title,
        size: 48,
      ),
      onTap: () {
        navigator(context).pushSurveyDetail(surveyUuid: survey.uuid);
      },
    );
  }
}
