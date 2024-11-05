import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sage_flutter/router.gr.dart';

@RoutePage()
class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: SafeArea(
        minimum: EdgeInsets.only(bottom: 24),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Spacer(flex: 1),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 300),
                child: Container(
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
              ),
              SizedBox(height: 24),
              Text(
                'Sage Survey',
                textAlign: TextAlign.center,
                style: theme.textTheme.displayMedium
                    ?.copyWith(color: theme.colorScheme.onPrimary),
              ),
              Spacer(flex: 2),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.router.push(LoginRoute());
                  },
                  child: Text('Log in'),
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      theme.colorScheme.tertiary,
                    ),
                    foregroundColor: WidgetStatePropertyAll(
                      theme.colorScheme.onTertiaryContainer,
                    ),
                  ),
                  child: Text('Create account'),
                ),
              ),
              // Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
