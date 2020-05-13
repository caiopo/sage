import 'package:flutter/material.dart';
import 'package:sage/widgets/identicon.dart';

class IdenticonTextField extends StatelessWidget {
  final String title;
  final ValueChanged<String> onChanged;

  IdenticonTextField({
    Key key,
    this.title,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Identicon(
          value: title,
          size: 64,
        ),
        SizedBox(width: 16),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Pesquisa de Opinião',
              labelText: 'Título',
            ),
            style: const TextStyle(fontSize: 18),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
