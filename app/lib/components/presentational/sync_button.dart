import 'package:flutter/material.dart';
import 'package:gaia/screens/routes.dart';

class SyncButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      icon: Icon(
        Icons.sync,
        color: Colors.white,
      ),
      label: Text(
        'SYNC',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        Navigator.push(context, Routes.sync());
      },
    );
  }
}
