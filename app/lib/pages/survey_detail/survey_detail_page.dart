import 'package:flutter/material.dart';

class SurveyDetailPage extends StatefulWidget {
  final String surveyUuid;

  SurveyDetailPage({@required this.surveyUuid});

  @override
  _SurveyDetailPageState createState() => _SurveyDetailPageState();
}

class _SurveyDetailPageState extends State<SurveyDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Survey'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Survey 1',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
