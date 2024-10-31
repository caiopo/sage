import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sage_flutter/providers/client.dart';
import 'package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

part 'auth.g.dart';

@Riverpod(keepAlive: true)
Future<SessionManager> sessionManager(Ref ref) async {
  final client = ref.watch(clientProvider);

  final sessionManager = SessionManager(
    caller: client.modules.auth,
  );

  await sessionManager.initialize();

  ref.onDispose(sessionManager.dispose);

  return sessionManager;
}

@riverpod
EmailAuthController authController(Ref ref) {
  final client = ref.watch(clientProvider);
  final controller = EmailAuthController(client.modules.auth);
  return controller;
}
