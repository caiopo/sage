import 'package:flutter/material.dart';
import 'package:sage/pages/survey_create/discard_dialog.dart';
import 'package:sage/router/router.dart';

class SurveyCreatePage extends StatefulWidget {
  @override
  _SurveyCreatePageState createState() => _SurveyCreatePageState();
}

class _SurveyCreatePageState extends State<SurveyCreatePage> {
  Future<bool> onWillPop() async {
    final quit = await showDialog<bool>(
      context: context,
      builder: (context) => DiscardDialog(),
    );

    return quit ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Novo questionário'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.save,
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
//            navigator(context).pushAn
          },
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Container();
  }
}
