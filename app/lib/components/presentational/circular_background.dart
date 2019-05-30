import 'package:flutter/material.dart';

class CircularBackground extends StatelessWidget {
  final Widget child;

  const CircularBackground({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: CircleBorder(),
      ),
      child: child,
    );
  }
}
