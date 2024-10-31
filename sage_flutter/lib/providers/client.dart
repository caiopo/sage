import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sage_client/sage_client.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

part 'client.g.dart';

const ipAddress = 'localhost';

@Riverpod(keepAlive: true)
Client client(Ref ref) {
  final client = Client(
    'http://$ipAddress:8080/',
    authenticationKeyManager: FlutterAuthenticationKeyManager(),
  )..connectivityMonitor = FlutterConnectivityMonitor();
  return client;
}

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
