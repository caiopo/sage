import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sage_flutter/providers/auth.dart';
import 'package:serverpod_auth_client/serverpod_auth_client.dart';

part 'user.g.dart';

@Riverpod(keepAlive: true)
Future<UserInfo?> currentUserFuture(Ref ref) async {
  final sessionManager = await ref.watch(sessionManagerProvider.future);

  void onUserChanged() {
    ref.invalidateSelf();
  }

  sessionManager.addListener(onUserChanged);
  ref.onDispose(() => sessionManager.removeListener(onUserChanged));

  return sessionManager.signedInUser;
}

@Riverpod(keepAlive: false)
UserInfo? currentUser(Ref ref) {
  final user = ref.watch(currentUserFutureProvider);
  return user.valueOrNull;
}
