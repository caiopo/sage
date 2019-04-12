import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gaia/business/auth.dart';
import 'package:gaia/screens/auth/google_sign_in_button.dart';
import 'package:gaia/utils/hooks.dart';

class AuthScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final loading = useState(true);

    useAsyncEffect(() async {
      if (await hasSavedTokens()) {
        await handleSignIn();
        await Navigator.pushReplacementNamed(context, '/home');
      } else {
        loading.value = false;
      }
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        child: Center(
          child: loading.value
              ? CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GoogleSignInButton(
                      onPressed: () async {
                        loading.value = true;
                        await handleSignIn();
                        await Navigator.pushReplacementNamed(context, '/home');
                      },
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
