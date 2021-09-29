import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SageWordmark extends StatelessWidget {
  final double fontSize;

  const SageWordmark({Key? key, required this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      'Sage',
      style: theme.textTheme.headline3?.copyWith(
        fontSize: fontSize,
        color: Colors.white,
      ),
    );
  }
}
