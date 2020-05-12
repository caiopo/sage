class AppException implements Exception {
  final String message;

  const AppException([this.message]);
}

class DerivedException extends AppException {
  final dynamic cause;

  const DerivedException(this.cause);
}
