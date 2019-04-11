import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gaia/screens/auth/google_sign_in_button.dart';
import 'package:gaia/utils/hooks.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _SIGN_IN_TOKENS_KEY = 'sign_in_tokens';

Future<void> saveTokens(List<String> tokens) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setStringList(_SIGN_IN_TOKENS_KEY, tokens);
}

Future<List<String>> getSavedTokens() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  if (!prefs.containsKey(_SIGN_IN_TOKENS_KEY)) {
    return null;
  }

  return prefs.getStringList(_SIGN_IN_TOKENS_KEY);
}

Future<List<String>> getUserTokens() async {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  return [googleAuth.accessToken, googleAuth.idToken];
}

Future<void> handleSignIn(BuildContext context) async {
  var credentials = await getSavedTokens();

  if (credentials == null) {
    credentials = await getUserTokens();
    await saveTokens(credentials);
  }

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: credentials[0],
    idToken: credentials[1],
  );

  await FirebaseAuth.instance.signInWithCredential(credential);

  await Navigator.pushReplacementNamed(context, '/home');
}

class AuthScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final loading = useState(true);

    useAsyncEffect(() async {
      final credentials = await getSavedTokens();
      if (credentials == null) {
        loading.value = false;
      } else {
        await handleSignIn(context);
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
                        await handleSignIn(context);
                        loading.value = false;
                      },
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
