import 'package:flutter/material.dart';

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
            Navigator.pop(context, true);
          },
        ),
        FlatButton(
          child: Text(
            'STAY',
          ),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
      ],
    );
  }
}
