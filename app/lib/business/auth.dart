import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _SIGN_IN_TOKENS_KEY = 'sign_in_tokens';

Future<void> saveTokens(List<String> tokens) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setStringList(_SIGN_IN_TOKENS_KEY, tokens);
}

Future<List<String>> getSavedTokens() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  if (!await hasSavedTokens()) {
    return null;
  }

  return prefs.getStringList(_SIGN_IN_TOKENS_KEY);
}

Future<bool> hasSavedTokens() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.containsKey(_SIGN_IN_TOKENS_KEY);
}

Future<List<String>> getUserTokens() async {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  return [googleAuth.accessToken, googleAuth.idToken];
}

Future<FirebaseUser> handleSignIn() async {
  var credentials = await getSavedTokens();

  if (credentials == null) {
    credentials = await getUserTokens();
    await saveTokens(credentials);
  }

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: credentials[0],
    idToken: credentials[1],
  );

  return await FirebaseAuth.instance.signInWithCredential(credential);
}
