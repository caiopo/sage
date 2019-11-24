import 'package:flutter/material.dart';

class Ghost extends StatelessWidget {
  final bool show;
  final Widget child;
  final Duration duration;

  const Ghost({
    Key key,
    @required this.show,
    @required this.child,
    this.duration = const Duration(milliseconds: 150),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !show,
      child: AnimatedOpacity(
        opacity: show ? 1 : 0,
        duration: duration,
        child: child,
      ),
    );
  }
}
