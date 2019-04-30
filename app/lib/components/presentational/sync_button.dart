import 'package:flutter/material.dart';

class SyncButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      icon: Icon(
        Icons.sync,
        color: Colors.white,
      ),
      label: Text(
        'SYNCHRONIZE',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {},
    );
  }
}
