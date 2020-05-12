import 'package:flutter/material.dart';
import 'package:sage/widgets/delayed.dart';

class DiscardDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Descartar mudanças?'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Se você voltar agora, suas mudanças serão descartadas.'),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            'FICAR',
          ),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        Delayed(
          delay: const Duration(seconds: 5),
          child: FlatButton(
            child: Text(
              'DESCARTAR',
              style: TextStyle(
                color: Theme.of(context).errorColor,
              ),
            ),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
        ),
      ],
    );
  }
}
