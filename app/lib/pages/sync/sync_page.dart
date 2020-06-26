import 'package:flutter/material.dart';
import 'package:sage/business/sync_business.dart';
import 'package:sage/di/di.dart';

class SyncPage extends StatefulWidget {
  @override
  _SyncPageState createState() => _SyncPageState();
}

class _SyncPageState extends State<SyncPage> {
  @override
  void initState() {
    super.initState();
    inject<SyncBusiness>().synchronize().listen(print, onError: print);
  }

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
          Text('Synchronizing...', style: TextStyle(fontSize: 24)),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}
