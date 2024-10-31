import 'package:flutter/material.dart';

class ButtonBottomBar extends StatelessWidget {
  const ButtonBottomBar({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SafeArea(
          top: false,
          minimum: const EdgeInsets.only(bottom: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          ),
        ),
      ),
    );
  }
}
