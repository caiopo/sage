import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sage/business/auth_business.dart';
import 'package:sage/pages/login/login_page.dart';
import 'package:sage/widgets/sage_wordmark.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SageWordmark(fontSize: 28),
      ),
      drawer: _Drawer(),
      body: Container(),
    );
  }
}

class _Drawer extends StatelessWidget {
  const _Drawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = FirebaseAuth.instance.currentUser!;

    final displayName = user.displayName ?? 'User';

    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              child: Text(
                displayName
                    .substring(0, min(2, displayName.length))
                    .toUpperCase(),
                style: theme.textTheme.bodyText1?.copyWith(fontSize: 18),
              ),
              backgroundColor: theme.colorScheme.secondary,
              foregroundColor: theme.colorScheme.onSecondary,
              foregroundImage:
                  user.photoURL != null ? NetworkImage(user.photoURL!) : null,
            ),
            accountEmail: Text(user.email ?? ''),
            accountName: Text(displayName),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () async {},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () async {},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sign out'),
            onTap: () async {
              await signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
