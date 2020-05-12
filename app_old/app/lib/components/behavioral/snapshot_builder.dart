import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget defaultLoading(BuildContext context) {
  return Center(child: CircularProgressIndicator());
}

Widget defaultError(BuildContext context, Object error) {
  final theme = Theme.of(context);

  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          FontAwesomeIcons.times,
          size: 48,
          color: theme.errorColor,
        ),
        SizedBox(height: 16),
        Text(
          "Error",
          style: theme.textTheme.headline,
        ),
      ],
    ),
  );
}

class SnapshotBuilder<T> extends HookWidget {
  final AsyncSnapshot<T> snapshot;
  final WidgetBuilder loading;
  final Widget Function(BuildContext context, T data) success;
  final Widget Function(BuildContext context, Object error) error;

  SnapshotBuilder({
    @required this.snapshot,
    @required this.success,
    this.loading = defaultLoading,
    this.error = defaultError,
  });

  @override
  Widget build(BuildContext context) {
    assert(snapshot != null && success != null);

    if (snapshot.hasData) {
      return success(context, snapshot.data);
    }

    if (snapshot.hasError) {
      return error(context, snapshot.error);
    }

    return loading(context);
  }
}
