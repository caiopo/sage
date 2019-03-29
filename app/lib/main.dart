import 'package:flutter/material.dart';
import 'package:gaia/screens/auth/auth_screen.dart';
import 'package:gaia/screens/home/home_screen.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gaia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      routes: {
        '/': (context) => AuthScreen(),
        '/home': (context) => HomeScreen(),
      },
      initialRoute: '/',
    );
  }
}
