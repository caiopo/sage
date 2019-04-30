import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gaia/utils/hooks/misc.dart';

class SyncScreenArguments {
  final bool goToHome;

  const SyncScreenArguments({bool goToHome})
      : this.goToHome = goToHome ?? false;
}

class SyncScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final theme = useTheme();

    return Scaffold(
      appBar: AppBar(
        title: Text('Sync'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            CircularProgressIndicator(),
            Text(
              "Synchronizing",
              style: theme.textTheme.display1,
            )
          ],
        ),
      ),
    );
  }
}
