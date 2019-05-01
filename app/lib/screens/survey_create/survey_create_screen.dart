import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gaia/models/models.dart';
import 'package:gaia/screens/survey_create/discard_dialog.dart';
import 'package:gaia/screens/survey_create/question_list.dart';
import 'package:gaia/screens/survey_create/survey_info.dart';

class SurveyCreateScreen extends HookWidget {
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Creating new survey'),
      bottom: TabBar(tabs: <Widget>[
        Tab(
          text: "General Info",
        ),
        Tab(
          text: "Questions",
        ),
      ]),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = useState('');

    return WillPopScope(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: buildAppBar(context),
          body: TabBarView(
            children: <Widget>[
              SurveyInfo(
                title: title,
              ),
              QuestionList(
                questions: List.generate(
                  100,
                  (i) => SurveyQuestion(id: i, title: 'oi $i'),
                ),
              ),
            ],
          ),
        ),
      ),
      onWillPop: () {
        return showDialog<bool>(
          context: context,
          builder: (context) => DiscardDialog(),
        ).then((b) => b ?? false);
      },
    );
  }
}
