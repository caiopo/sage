import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gaia/utils/hooks/misc.dart';

class SurveyCreateScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final theme = useTheme();

    return Scaffold(
      appBar: AppBar(
        title: Text('Creating new survey'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'General info',
                style: theme.textTheme.title,
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Pesquisa de Opinião",
                labelText: "Title",
              ),
              style: theme.textTheme.subhead.copyWith(fontSize: 18),
              autofocus: true,
            ),
            Divider(height: 32),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Questions',
                style: theme.textTheme.title,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DiscardDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Discard Changes?'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('If you go back now, your draft will be discarded.'),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            'DISCARD',
            style: TextStyle(
              color: Theme.of(context).errorColor,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
        FlatButton(
          child: Text(
            'STAY',
          ),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
      ],
    );
  }
}
