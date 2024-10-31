import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sage_flutter/providers/observer.dart';
import 'package:sage_flutter/router.dart';
import 'package:sage_flutter/theme.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends HookWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = useMemoized(() => AppRouter());

    final brightness = Brightness.light;
    // final brightness = Brightness.dark;

    return ProviderScope(
      observers: [
        DebugProviderObserver(),
      ],
      child: MaterialApp.router(
        title: 'Serverpod Demo',
        theme: createTheme(context, brightness),
        routerConfig: router.config(),
      ),
    );
  }
}
