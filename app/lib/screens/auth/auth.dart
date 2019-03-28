import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gaia/screens/auth/google_sign_in_button.dart';
import 'package:gaia/utils/hooks.dart';
import 'package:google_sign_in/google_sign_in.dart';


class AuthScreen extends HookWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<FirebaseUser> _handleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return FirebaseAuth.instance.signInWithCredential(credential);

//    Navigator.pushNamed(context, )
  }

  @override
  Widget build(BuildContext context) {
    final user = useState<FirebaseUser>(null);
    final theme = useTheme();

    user.value.getIdToken(refresh: true);

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                user.value != null
                    ? "Signed with ${user.value.displayName}"
                    : 'Not signed in',
                style: theme.textTheme.headline,
              ),
              SizedBox(height: 20),
              GoogleSignInButton(
                onPressed: () async {
                  user.value = await this._handleSignIn();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
