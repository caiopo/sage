import 'package:flutter/material.dart';

class Debug extends StatelessWidget {
  const Debug({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      foregroundDecoration: BoxDecoration(
        border: Border.all(),
      ),
      child: child,
    );
  }
}
