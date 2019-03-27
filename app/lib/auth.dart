import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gaia/utils/hooks.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  GoogleSignInButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      color: Color(0xFF4285F4),
      padding: EdgeInsets.all(2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: Container(
              color: Colors.white,
              child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Image.asset(
                    'assets/images/g-logo.png',
                    height: 18,
                    width: 18,
                  )),
            ),
          ),
          SizedBox(width: 16),
          Text(
            'Sign in with Google',
            style: TextStyle(
              fontFamily: 'Roboto',
              color: Colors.white,
            ),
          ),
          SizedBox(width: 8),
        ],
      ),
    );
  }
}

class AuthScreen extends HookWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> _handleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return _auth.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    final user = useState<FirebaseUser>(null);
    final theme = useTheme();

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
