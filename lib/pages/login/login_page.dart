import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sage/business/auth_business.dart';
import 'package:sage/config.dart';
import 'package:sage/pages/home/home_page.dart';
import 'package:sage/widgets/login_buttons.dart';
import 'package:sage/widgets/sage_wordmark.dart';

class LoginPage extends HookWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final loading = useState(false);

    print(FirebaseAuth.instance.currentUser);

    Future<void> login(AsyncCallback callback) async {
      loading.value = true;
      try {
        await callback();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomePage()),
        );
      } on SignInException catch (e) {
        print(e);
      } finally {
        loading.value = false;
      }
    }

    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: CircleBorder(),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Image.asset(
                    'assets/images/ginger-cat/track-statistics.png',
                  ),
                ),
              ),
              SizedBox(height: 8),
              SageWordmark(fontSize: 72),
              SizedBox(height: 32),
              GoogleSignInButton(
                onPressed: () => login(signInWithGoogle),
              ),
              SizedBox(height: 8),
              if (kEnableAppleLogin)
                AppleSignInButton(
                  onPressed: () => login(signInWithApple),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
