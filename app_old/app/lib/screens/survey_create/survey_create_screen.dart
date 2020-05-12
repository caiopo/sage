import 'package:flutter/material.dart';
import 'package:gaia/models/models.dart';
import 'package:gaia/screens/routes.dart';
import 'package:gaia/screens/survey_create/discard_dialog.dart';
import 'package:gaia/screens/survey_create/identicon_text_field.dart';
import 'package:gaia/screens/survey_create/question_list_item.dart';

class SurveyCreateScreen extends StatefulWidget {
  @override
  _SurveyCreateScreenState createState() => _SurveyCreateScreenState();
}

class _SurveyCreateScreenState extends State<SurveyCreateScreen> {
  Survey survey = Survey(
    title: '',
    questions: [
      SurveyQuestion(
        title: 'Aaaaaaaaaaaaaaaaaaaa',
      ),
      SurveyQuestion(
        title: 'Aaaaaaaaaaaaaaaaaaaa',
      ),
      SurveyQuestion(
        title: 'Aaaaaaaaaaaaaaaaaaaa',
      ),
      SurveyQuestion(
        title: 'Aaaaaaaaaaaaaaaaaaaa',
      ),
      SurveyQuestion(
        title: 'Aaaaaaaaaaaaaaaaaaaa',
      ),
      SurveyQuestion(
        title: 'Aaaaaaaaaaaaaaaaaaaa',
      ),
      SurveyQuestion(
        title: 'Aaaaaaaaaaaaaaaaaaaa',
      ),
      SurveyQuestion(
        title: 'Aaaaaaaaaaaaaaaaaaaa',
      ),
      SurveyQuestion(
        title: 'Aaaaaaaaaaaaaaaaaaaa',
      ),
      SurveyQuestion(
        title: 'Aaaaaaaaaaaaaaaaaaaa',
      ),
      SurveyQuestion(
        title: 'Aaaaaaaaaaaaaaaaaaaa',
      ),
      SurveyQuestion(
        title: 'Aaaaaaaaaaaaaaaaaaaa',
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
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
        floatingActionButton: FloatingActionButton(
          tooltip: 'Adicionar pergunta',
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(context, Routes.questionCreate());
          },
        ),
        body: buildBody(),
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

  Widget buildBody() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Text(
                'Informações gerais',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
            ),
            IdenticonTextField(
              title: survey.title,
              onChanged: (value) {
                setState(() => survey.title = value);
              },
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 8,
                left: 16,
                right: 16,
              ),
              child: Text(
                'Perguntas',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
            ),
          ]),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final question = survey.questions[index];

              return QuestionListItem(
                question: question,
              );
            },
            childCount: survey.questions.length,
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(height: 72),
          ]),
        ),
      ],
    );
  }
}
