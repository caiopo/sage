import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gaia/screens/login/login_screen.dart';

void main() {
  runApp(App());
}

class App extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gaia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: LoginScreen(),
    );
  }
}
