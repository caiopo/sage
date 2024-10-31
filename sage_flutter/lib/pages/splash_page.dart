import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sage_flutter/providers/user.dart';
import 'package:sage_flutter/utils/hooks.dart';

@RoutePage()
class SplashPage extends HookConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      currentUserFutureProvider,
      (_, user) {
        if (!user.isLoading) {
          if (user.valueOrNull == null) {
            context.router.replaceNamed('/auth');
          } else {
            context.router.replaceNamed('/home');
          }
        }
      },
    );

    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
