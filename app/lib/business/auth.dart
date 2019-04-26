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

Future<void> clearTokens() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove(_SIGN_IN_TOKENS_KEY);
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

Future<FirebaseUser> signInWith(List<String> tokens) async {
  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: tokens[0],
    idToken: tokens[1],
  );

  return await FirebaseAuth.instance.signInWithCredential(credential);
}

Future<FirebaseUser> handleSignIn({bool retrying = false}) async {
  var tokens = await getSavedTokens();

  if (tokens == null) {
    tokens = await getUserTokens();
    await saveTokens(tokens);
  }

  try {
    return await signInWith(tokens);
  } on Exception {
    await clearTokens();

    if (retrying) {
      return handleSignIn(retrying: true);
    }

    return null;
  }
}
