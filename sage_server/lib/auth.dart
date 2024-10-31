import 'package:serverpod_auth_server/serverpod_auth_server.dart';

final authConfig = AuthConfig(
  sendValidationEmail: (session, email, validationCode) async {
    print('validation $email: $validationCode');
    return true;
  },
);
