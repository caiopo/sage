import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoogleSignInButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/login/google.png',
            width: 18,
            height: 18,
          ),
          SizedBox(width: 24),
          Text('Sign in with Google'),
        ],
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        foregroundColor: MaterialStateProperty.all(Colors.black54),
        overlayColor: MaterialStateProperty.all(Colors.black12),
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 8)),
        fixedSize: MaterialStateProperty.all(Size.fromHeight(40)),
        textStyle: MaterialStateProperty.all(
          GoogleFonts.roboto(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

class AppleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AppleSignInButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/login/apple.png',
            width: 18,
            height: 18,
          ),
          SizedBox(width: 24),
          Text('Sign in with Apple'),
        ],
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.black),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        overlayColor: MaterialStateProperty.all(Colors.white24),
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 8)),
        fixedSize: MaterialStateProperty.all(Size.fromHeight(40)),
        textStyle: MaterialStateProperty.all(theme.textTheme.bodyText1),
      ),
    );
  }
}
