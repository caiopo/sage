import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  final String text;
  final double paddingBottom;

  const EmptyList({Key key, this.text, this.paddingBottom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset('assets/images/ginger-cat/page-not-found.png'),
        Text(text, style: TextStyle(fontSize: 24)),
        SizedBox(height: paddingBottom)
      ],
    );
  }
}
