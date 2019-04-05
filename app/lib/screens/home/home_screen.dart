import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gaia/components/snapshot_builder.dart';
import 'package:http/http.dart';

class HomeScreen extends HookWidget {
  final Future<FirebaseUser> user = FirebaseAuth.instance.currentUser();

  @override
  Widget build(BuildContext context) {
    final snapshot = useFuture(user);

    final callApi = () async {
      if (snapshot.hasData) {
        final user = snapshot.data;

        final token = await user.getIdToken(refresh: true);

        final url = 'http://10.0.2.2:5000/surveys/1?token=$token';

        print(url);

        final response = await get(url);

        debugPrint(response.body);
      }
    };

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
          return Stack(
            children: <Widget>[
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Oi, ${user.displayName}'),
                    RaisedButton(
                      child: Text('Oi'),
                      onPressed: callApi,
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 16,
                right: 16,
                child: FloatingActionButton(
                  tooltip: 'Create Survey',
                  child: Icon(
                    Icons.add,
                  ),
                  onPressed: () {},
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class SurveyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, i) {

    });
  }
}
