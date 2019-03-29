import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gaia/components/snapshot_builder.dart';
import 'package:gaia/utils/hooks.dart';
import 'package:http/http.dart';

class HomeScreen extends HookWidget {
  final Future<FirebaseUser> user = FirebaseAuth.instance.currentUser();

  @override
  Widget build(BuildContext context) {
    final snapshot = useFuture(user);

    useAsyncEffect(() async {
      if (snapshot.hasData) {
        final user = snapshot.data;

        final token = await user.getIdToken(refresh: true);

        print('calling server with token: $token');

        final response = await get('http://10.0.2.2:5000/users/?token=$token');

        print(response.body);
      }
    }, <Object>[snapshot]);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: snapshot.hasData
            ? <Widget>[
                IconButton(
                  icon: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      snapshot.data.providerData.first.photoUrl,
                    ),
                  ),
                  onPressed: () {},
                )
              ]
            : null,
      ),
      body: SnapshotBuilder<FirebaseUser>(
        snapshot: snapshot,
        success: (context, user) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Oi, ${user.displayName}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
