import 'package:flutter/material.dart';

class SlideInAnimation extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  static final _tween = Tween<Offset>(
    begin: const Offset(1.5, 0.0),
    end: Offset.zero,
  );

  const SlideInAnimation({
    Key key,
    @required this.animation,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: animation,
      axisAlignment: 1,
      child: SlideTransition(
        position: animation.drive(_tween),
        child: child,
      ),
    );
  }
}
