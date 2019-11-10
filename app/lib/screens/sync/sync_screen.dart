import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SyncScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sincronização'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/images/ginger-cat/uploading.png'),
          SizedBox(height: 16),
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Sincronizando...', style: TextStyle(fontSize: 24)),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}
