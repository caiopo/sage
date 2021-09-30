import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sage/pages/home/home_page.dart';
import 'package:sage/pages/login/login_page.dart';
import 'package:sage/utils/firebase.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFirebase();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sage Survey',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        colorScheme: const ColorScheme.light(
          primary: Color(0xFFDA5C47),
          primaryVariant: Color(0xFFA32B1E),
          secondary: Color(0xFFB0D57E),
          secondaryVariant: Color(0xFF7FA450),
        ),
        textTheme: GoogleFonts.openSansTextTheme().copyWith(
          headline3: GoogleFonts.mali(
            fontSize: 48,
            fontWeight: FontWeight.w600,
          ),
          bodyText1: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      home:
          FirebaseAuth.instance.currentUser == null ? LoginPage() : HomePage(),
    );
  }
}
