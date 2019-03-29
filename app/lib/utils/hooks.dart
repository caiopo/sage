import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

ThemeData useTheme() {
  final context = useContext();
  return Theme.of(context);
}

void useAsyncEffect(Future<dynamic> Function() effect, [List keys]) {
  useEffect(() {
    effect();
  }, keys);
}

T useArguments<T>() {
  return useMemoized(() {
    final context = useContext();

    final arguments = ModalRoute.of(context).settings.arguments;

    if (arguments is T) {
      return arguments;
    }

    return null;
  });
}
