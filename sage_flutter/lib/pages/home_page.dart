import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sage_flutter/providers/user.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

@RoutePage()
class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      drawer: Drawer(
        child: UserAccountsDrawerHeader(
          currentAccountPicture: CircularUserImage(
            userInfo: user,
            size: 48,
          ),
          accountName: Text(user?.fullName ?? ''),
          accountEmail: Text(user?.email ?? ''),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularUserImage(
            userInfo: user,
            size: 48,
          ),
          Text(user?.userName ?? ''),
        ],
      ),
    );
  }
}
