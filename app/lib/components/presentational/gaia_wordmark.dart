import 'package:flutter/material.dart';

class GaiaWordmark extends StatelessWidget {
  final double size;

  const GaiaWordmark({Key key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Gaia',
      style: TextStyle(
        fontFamily: 'Mali SemiBold',
        fontSize: size,
        color: Colors.white,
      ),
    );
  }
}
