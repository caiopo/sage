import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sage/widgets/ghost.dart';

class Delayed extends StatefulWidget {
  final Duration delay;
  final Widget child;

  const Delayed({
    Key key,
    @required this.delay,
    @required this.child,
  }) : super(key: key);

  @override
  _DelayedState createState() => _DelayedState();
}

class _DelayedState extends State<Delayed> {
  static const _timerFrequency = Duration(milliseconds: 50);

  Duration remaining;

  Timer _timer;

  bool done = false;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(
      _timerFrequency,
      (timer) {
        setState(() {
          remaining = widget.delay - (_timerFrequency * timer.tick);
          if (remaining.isNegative) {
            _timer.cancel();
            _timer = null;
            done = true;
          }
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.delay.inMilliseconds;
    final current = remaining?.inMilliseconds;

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Ghost(
          show: done,
          child: widget.child,
        ),
        Ghost(
          show: !done,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
            value: remaining == null ? 0 : (total - current) / total,
          ),
        ),
      ],
    );
  }
}
