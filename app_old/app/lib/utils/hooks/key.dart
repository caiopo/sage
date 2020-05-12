import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

GlobalKey<T> useGlobalKey<T extends State<StatefulWidget>>({
  String text,
  List keys,
}) {
  return Hook.use(_GlobalKeyHook(
    text: text,
    keys: keys,
  ));
}

class _GlobalKeyHook<T extends State<StatefulWidget>>
    extends Hook<GlobalKey<T>> {
  final String text;

  const _GlobalKeyHook({
    this.text,
    List keys,
  }) : super(keys: keys);

  @override
  _GlobalKeyHookState<T> createState() => _GlobalKeyHookState<T>();
}

class _GlobalKeyHookState<T extends State<StatefulWidget>>
    extends HookState<GlobalKey<T>, _GlobalKeyHook<T>> {

  GlobalKey<T> _key;

  @override
  GlobalKey<T> build(BuildContext context) {
    return _key ??= GlobalKey<T>();
  }
}
