import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({
    super.key,
    required this.child,
    required this.bottom,
  });

  final Widget child;
  final Widget bottom;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: child),
        bottom,
      ],
    );
  }
}
