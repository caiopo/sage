import 'package:flutter/material.dart';
import 'package:sage/widgets/identicon.dart';

class IdenticonTextField extends StatelessWidget {
  final String title;
  final String error;
  final ValueChanged<String> onSaved;

  IdenticonTextField({
    Key key,
    this.title,
    this.error,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Identicon(
          value: title,
          size: 64,
        ),
        SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Pesquisa de Opinião',
              labelText: 'Título do questionário',
              helperText: 'Obrigatório',
            ),
            maxLength: 200,
            validator: (title) {
              if (title == null || title.isEmpty) {
                return 'Obrigatório';
              }

              return null;
            },
            onSaved: onSaved,
          ),
        ),
      ],
    );
  }
}
