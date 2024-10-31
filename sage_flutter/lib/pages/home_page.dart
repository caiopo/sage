import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sage_flutter/providers/auth.dart';
import 'package:sage_flutter/providers/user.dart';
import 'package:sage_flutter/router.gr.dart';
import 'package:serverpod_auth_client/src/protocol/user_info.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

@RoutePage()
class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final user = ref.watch(currentUserProvider);

    void signOut() {
      context.router.replaceAll(
        [LoginRoute()],
        updateExistingRoutes: false,
      );

      ref.read(sessionManagerProvider).valueOrNull?.signOut();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Sage'),
        backgroundColor: theme.colorScheme.primaryContainer,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
      drawer: HomeDrawer(
        user: user,
        theme: theme,
        onSignOut: signOut,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text('New survey'),
        icon: Icon(Icons.add),
      ),
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Hello you are logged in: ${user?.userName}'),
          ],
        ),
      ),
    );
  }
}

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    super.key,
    required this.user,
    required this.theme,
    required this.onSignOut,
  });

  final UserInfo? user;
  final ThemeData theme;
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: LinearBorder(),
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircularUserImage(userInfo: user),
            accountName: Text(user?.userName ?? ''),
            accountEmail: Text(user?.email ?? ''),
          ),
          Expanded(child: SizedBox()),
          SafeArea(
            top: false,
            child: ListTile(
              iconColor: theme.colorScheme.error,
              textColor: theme.colorScheme.error,
              leading: Icon(Icons.logout),
              title: Text('Sign out'),
              onTap: onSignOut,
            ),
          ),
        ],
      ),
    );
  }
}
