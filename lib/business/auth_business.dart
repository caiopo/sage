import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sage/core/exceptions.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final googleUser = await GoogleSignIn().signIn();

  if (googleUser == null) {
    throw SignInException(SignInErrorReason.cancelled);
  }

  // Obtain the auth details from the request
  final googleAuth = await googleUser.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  try {
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  } on FirebaseAuthException catch (e) {
    _handleFirebaseAuthException(e);
    rethrow;
  }
}

Future<UserCredential> signInWithApple() async {
  // To prevent replay attacks with the credential returned from Apple, we
  // include a nonce in the credential request. When signing in with
  // Firebase, the nonce in the id token returned by Apple, is expected to
  // match the sha256 hash of `rawNonce`.
  final rawNonce = generateNonce();
  final nonce = sha256ofString(rawNonce);

  late AuthorizationCredentialAppleID appleCredential;
  try {
    // Request credential for the currently signed in Apple account.
    appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );
  } on SignInWithAppleAuthorizationException catch (e) {
    if (e.code == AuthorizationErrorCode.canceled) {
      throw SignInException(SignInErrorReason.cancelled, e.message);
    }
    throw SignInException(SignInErrorReason.unknownError, e.message);
  } on SignInWithAppleException catch (e) {
    print(e); // TODO
    throw SignInException(SignInErrorReason.unknownError);
  }

  // Create an `OAuthCredential` from the credential returned by Apple.
  final oauthCredential = OAuthProvider('apple.com').credential(
    idToken: appleCredential.identityToken,
    rawNonce: rawNonce,
  );

  try {
    // Sign in the user with Firebase. If the nonce we generated earlier does
    // not match the nonce in `appleCredential.identityToken`, sign in will fail.
    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  } on FirebaseAuthException catch (e) {
    _handleFirebaseAuthException(e);
    rethrow;
  }
}

Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
}

/// Generates a cryptographically secure random nonce, to be included in a
/// credential request.
String generateNonce([int length = 32]) {
  const charset =
      '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
  final random = Random.secure();
  return List.generate(length, (_) => charset[random.nextInt(charset.length)])
      .join();
}

/// Returns the sha256 hash of [input] in hex notation.
String sha256ofString(String input) {
  final bytes = utf8.encode(input);
  final digest = sha256.convert(bytes);
  return digest.toString();
}

void _handleFirebaseAuthException(FirebaseAuthException exception) {
  switch (exception.code) {
    case 'account-exists-with-different-credential':
      throw SignInException(
        SignInErrorReason.accountExistsWithDifferentCredential,
      );
    case 'invalid-credential':
      throw SignInException(SignInErrorReason.invalidCredential);
    case 'user-disabled':
      throw SignInException(SignInErrorReason.userDisabled);
    default:
      throw SignInException(SignInErrorReason.unknownError);
  }
}

class SignInException extends AppException {
  final SignInErrorReason reason;

  SignInException(this.reason, [String? message]) : super(message);

  @override
  String toString() {
    return 'SignInException{reason: $reason, message: $message}';
  }
}

enum SignInErrorReason {
  cancelled,
  accountExistsWithDifferentCredential,
  invalidCredential,
  userDisabled,
  unknownError,
}
