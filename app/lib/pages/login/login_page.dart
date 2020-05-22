import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:sage/router/router.dart';
import 'package:sage/widgets/circular_background.dart';
import 'package:sage/widgets/sage_wordmark.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (loading) return CircularProgressIndicator();

    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularBackground(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Image.asset(
                  'assets/images/ginger-cat/track-statistics.png',
                ),
              ),
            ),
            SizedBox(height: 8),
            SageWordmark(size: 72),
            SizedBox(height: 32),
            GoogleSignInButton(
              text: 'Entrar com Google',
              onPressed: () {
                navigator(context).pushReplacementNamed(Routes.home);
              },
            )
          ],
        ),
      ),
    );
  }
}
