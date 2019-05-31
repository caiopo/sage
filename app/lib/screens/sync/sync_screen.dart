import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SyncScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sync'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RotatingCat(),
          SizedBox(height: 16),
          Text('Synchronizing', style: TextStyle(fontSize: 24)),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}

class RotatingCat extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final left = useState(true);

    useEffect(() {
      final timer = Timer.periodic(
        Duration(milliseconds: 500),
        (t) => left.value = !left.value,
      );
      return timer.cancel;
    }, []);

    return Transform.rotate(
      angle: left.value ? -pi / 16 : pi / 16,
      child: Image.asset('assets/images/ginger-cat/uploading.png'),
    );
  }
}
