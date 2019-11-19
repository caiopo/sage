import 'package:flutter/material.dart';
import 'package:gaia/components/presentational/identicon.dart';

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
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Identicon(
            title,
            size: 64,
          ),
          SizedBox(width: 16),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Pesquisa de Opinião",
                labelText: "Título",
              ),
              style: Theme.of(context).textTheme.subhead.copyWith(fontSize: 18),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
