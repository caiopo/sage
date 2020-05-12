import 'package:flutter/material.dart';
import 'package:sage/data/db.dart';
import 'package:sage/pages/home/survey_tile.dart';
import 'package:sage/router/router.dart';
import 'package:sage/widgets/sage_wordmark.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SageWordmark(size: 26),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.sync),
            label: Text('SYNC'),
            textColor: Colors.white,
            onPressed: () {
              navigator(context).pushSync();
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return SurveyTile(
            survey: Survey(
              title: 'Teste $index',
              uploadedAnswers: index,
              uuid: 'aa',
            ),
          );
        },
      ),
    );
  }
}
