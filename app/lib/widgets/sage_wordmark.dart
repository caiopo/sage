import 'package:flutter/material.dart';

class SageWordmark extends StatelessWidget {
  final double size;

  const SageWordmark({Key key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Sage',
      style: TextStyle(
        fontFamily: 'Mali SemiBold',
        fontSize: size,
        color: Colors.white,
      ),
    );
  }
}
