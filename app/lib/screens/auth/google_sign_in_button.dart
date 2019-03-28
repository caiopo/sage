import 'package:flutter/material.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  GoogleSignInButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      color: Color(0xFF4285F4),
      padding: EdgeInsets.all(2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: Container(
              color: Colors.white,
              child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Image.asset(
                    'assets/images/g-logo.png',
                    height: 18,
                    width: 18,
                  )),
            ),
          ),
          SizedBox(width: 16),
          Text(
            'Sign in with Google',
            style: TextStyle(
              fontFamily: 'Roboto',
              color: Colors.white,
            ),
          ),
          SizedBox(width: 8),
        ],
      ),
    );
  }
}
