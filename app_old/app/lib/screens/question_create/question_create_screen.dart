import 'package:flutter/material.dart';
import 'package:gaia/components/presentational/collapsing_radio_group.dart';
import 'package:gaia/models/models.dart';
import 'package:gaia/screens/question_create/question_type_layouts.dart';
import 'package:gaia/utils/texts.dart';

class QuestionCreateScreen extends StatefulWidget {
  @override
  _QuestionCreateScreenState createState() => _QuestionCreateScreenState();
}

class _QuestionCreateScreenState extends State<QuestionCreateScreen> {
  SurveyQuestion question = SurveyQuestion(
    required: true,
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Nova pergunta'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Pergunta',
                  hintText: 'Qual sua cor favorita?',
                ),
                style: theme.textTheme.subhead.copyWith(fontSize: 20),
              ),
            ),
            SizedBox(height: 16),
            _buildSection('Tipo de pergunta'),
            CollapsingRadioGroup<QuestionType>(
              onSelected: (type) => setState(() => question.type = type),
              items: [
                for (final type in QuestionType.values)
                  RadioItem(
                    key: type,
                    label: questionTypeText(type),
                  ),
              ],
            ),
            _buildSection('Outras opções'),
            CheckboxListTile(
              title: Text('Obrigatória'),
              activeColor: Theme.of(context).primaryColor,
              controlAffinity: ListTileControlAffinity.leading,
              value: question.required,
              onChanged: (required) => setState(() {
                question.required = required;
              }),
            ),
            ..._buildTypeSpecific(),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Text(title, style: TextStyle(fontSize: 22)),
      ),
    );
  }

  List<Widget> _buildTypeSpecific() {
    switch (question.type) {
      case QuestionType.multiple:
        return [
          _buildSection('Respostas'),
          CreateMultipleChoiceQuestion(),
        ];

      case QuestionType.single:
        return [
          _buildSection('Respostas'),
          CreateSingleChoiceQuestion(),
        ];

      case QuestionType.number:
        return [
          CreateNumberQuestion(),
        ];

      case QuestionType.text:
        return [
          CreateTextQuestion(),
        ];
    }

    return [];
  }
}
