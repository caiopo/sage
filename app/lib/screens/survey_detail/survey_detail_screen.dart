import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gaia/models/models.dart';
import 'package:gaia/utils/hooks.dart';

class SurveyDetailScreen extends HookWidget {
  final Survey survey;

  SurveyDetailScreen({@required this.survey});

  @override
  Widget build(BuildContext context) {
    final theme = useTheme();

    return Scaffold(
      appBar: AppBar(
        title: Text('Survey'),
      ),
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  survey.title,
                  style: theme.textTheme.display1.copyWith(color: Colors.black87),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
