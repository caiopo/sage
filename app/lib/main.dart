import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gaia/screens/login/login_screen.dart';

void main() {
  runApp(App());
}

const _primaryColor = Color(0xFFDA5C47);
const _accentColor = Color(0xFFB0D57E);

class App extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gaia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        primaryColor: _primaryColor,
        accentColor: _accentColor,
      ),
      home: LoginScreen(),
    );
  }
}
