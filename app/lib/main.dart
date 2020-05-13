import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sage/di/di.dart';
import 'package:sage/router/router.dart';

void main() {
  configureDependencies();
  runApp(App());
}

const _primaryColor = Color(0xFFDA5C47);
const _accentColor = Color(0xFFB0D57E);

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sage',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        primaryColor: _primaryColor,
        accentColor: _accentColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.ubuntuTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      builder: ExtendedNavigator<Router>(router: Router()),
    );
  }
}
