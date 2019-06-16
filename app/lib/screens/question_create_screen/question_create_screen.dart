import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gaia/components/presentational/collapsing_radio_group.dart';
import 'package:gaia/models/models.dart';
import 'package:gaia/utils/texts.dart';

class QuestionCreateScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Question'),
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
                  labelText: "Question",
                  hintText: "Do you have a pet?",
                ),
                style: theme.textTheme.subhead.copyWith(fontSize: 20),
              ),
            ),
            SizedBox(height: 16),
            buildSection('Type'),
            CollapsingRadioGroup(
              items: <RadioItem<QuestionType>>[
                for (final type in QuestionType.values)
                  RadioItem(
                    key: type,
                    label: questionTypeText(type),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSection(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 22,
          ),
        ),
      ),
    );
  }
}
