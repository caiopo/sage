import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum AuthError {
  cancelled,
  userDisabled,
  generic,
}

Future<AuthCredential> getGoogleCredential() async {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount googleUser;
  try {
    googleUser = await googleSignIn.signIn();
  } catch (e) {
    throw AuthError.generic;
  }

  if (googleUser == null) {
    throw AuthError.cancelled;
  }

  final googleAuth = await googleUser.authentication;

  return GoogleAuthProvider.getCredential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
}
