import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gaia/business/auth.dart';
import 'package:gaia/screens/login/google_sign_in_button.dart';
import 'package:gaia/screens/routes.dart';
import 'package:gaia/utils/hooks/misc.dart';

class LoginScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final loading = useState(true);

    useAsyncEffect(() async {
      if (await hasSavedTokens()) {
        await handleSignIn();
        await Navigator.pushReplacement(context, Routes.surveyList());
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
                        await Navigator.pushReplacement(context, Routes.surveyList());
                      },
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
