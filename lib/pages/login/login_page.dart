import 'package:flutter/material.dart';
import 'package:sage/widgets/login_buttons.dart';
import 'package:sage/widgets/sage_wordmark.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: CircleBorder(),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Image.asset(
                    'assets/images/ginger-cat/track-statistics.png',
                  ),
                ),
              ),
              SizedBox(height: 8),
              SageWordmark(fontSize: 72),
              SizedBox(height: 32),
              GoogleSignInButton(
                onPressed: () {},
              ),
              SizedBox(height: 8),
              AppleSignInButton(
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
