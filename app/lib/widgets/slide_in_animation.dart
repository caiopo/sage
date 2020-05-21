import 'package:flutter/material.dart';

class SlideInTransition extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  static final _tween = Tween<Offset>(
    begin: const Offset(1.5, 0.0),
    end: Offset.zero,
  );

  const SlideInTransition({
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

class SlideInReveal extends StatefulWidget {
  final Widget child;

  const SlideInReveal({Key key, this.child}) : super(key: key);

  @override
  _SlideInRevealState createState() => _SlideInRevealState();
}

class _SlideInRevealState extends State<SlideInReveal>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _controller.animateTo(1);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideInTransition(
      animation: _controller,
      child: widget.child,
    );
  }
}
