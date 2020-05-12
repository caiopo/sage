import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gaia/components/presentational/circular_background.dart';
import 'package:gaia/components/presentational/gaia_wordmark.dart';
import 'package:gaia/screens/routes.dart';

class LoginScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final loading = useState(false);
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        child: Center(
          child: SizedBox.expand(
            child: Container(
              color: theme.primaryColor,
              child: loading.value
                  ? CircularProgressIndicator()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularBackground(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Image.asset(
                              'assets/images/ginger-cat/track-statistics.png',
                              scale: 0.1,
                            ),
                          ),
                        ),
                        GaiaWordmark(size: 72),
                        SizedBox(height: 8),
                        GoogleSignInButton(
                          text: 'Entrar com Google',
                          onPressed: () async {
                            await Navigator.pushReplacement(
                                context, Routes.surveyList());
                          },
                        )
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
