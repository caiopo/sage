import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

TextEditingController useTextEditingController({
  String text,
  List keys,
}) {
  return Hook.use(_TextEditingControllerHook(
    text: text,
    keys: keys,
  ));
}

class _TextEditingControllerHook extends Hook<TextEditingController> {
  final String text;

  const _TextEditingControllerHook({
    this.text,
    List keys,
  }) : super(keys: keys);

  @override
  _TextEditingControllerHookState createState() =>
      _TextEditingControllerHookState();
}

class _TextEditingControllerHookState
    extends HookState<TextEditingController, _TextEditingControllerHook> {
  TextEditingController _textEditingController;

  @override
  TextEditingController build(BuildContext context) {
    return _textEditingController ??= TextEditingController(
      text: hook.text,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }
}
