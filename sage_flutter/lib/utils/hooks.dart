import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

GlobalKey<T> useGlobalKey<T extends State<StatefulWidget>>() {
  return useMemoized(GlobalKey<T>.new);
}

void useAsyncEffect(Future<void> Function() effect, [List<Object?>? keys]) {
  useEffect(() {
    Future.microtask(effect);
    return null;
  }, keys);
}
