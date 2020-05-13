import 'package:flutter/material.dart';
import 'package:sage/data/db.dart';
import 'package:sage/router/router.dart';

class QuestionCreatePage extends StatefulWidget {
  final Question question;

  const QuestionCreatePage({Key key, this.question}) : super(key: key);

  @override
  _QuestionCreatePageState createState() => _QuestionCreatePageState();
}

class _QuestionCreatePageState extends State<QuestionCreatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nova pergunta',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.save,
              color: Colors.white,
            ),
            onPressed: () {
              navigator(context).pop();
            },
          )
        ],
      ),
      body: Container(),
    );
  }
}
