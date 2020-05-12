import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sage/utils/exceptions.dart';
import 'package:sage/utils/result.dart';

Future<Result<AuthCredential>> getGoogleCredentials() async {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount googleUser;
  try {
    googleUser = await googleSignIn.signIn();
  } catch (e) {
    return Result.error(AuthException(AuthError.generic));
  }

  if (googleUser == null) {
    return Result.error(AuthException(AuthError.cancelled));
  }

  final googleAuth = await googleUser.authentication;

  return Result.data(
    GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    ),
  );
}

enum AuthError {
  cancelled,
  userDisabled,
  generic,
}

class AuthException extends AppException {
  final AuthError cause;

  AuthException(this.cause);
}
