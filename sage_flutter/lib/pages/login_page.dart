import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sage_flutter/providers/auth.dart';
import 'package:sage_flutter/utils/hooks.dart';
import 'package:sage_flutter/widgets/body.dart';
import 'package:sage_flutter/widgets/button_bottom_bar.dart';

@RoutePage()
class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final loading = useState(false);
    final globalKey = useGlobalKey<FormBuilderState>();

    void onLoginPressed() async {
      if (loading.value) return;
      loading.value = true;
      await Future.delayed(Duration(seconds: 1));

      try {
        final form = globalKey.currentState!;

        if (form.saveAndValidate()) {
          final userInfo = await ref.read(authControllerProvider).signIn(
                form.value['email'],
                form.value['password'],
              );

          if (context.mounted) {
            if (userInfo == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Invalid credentials')),
              );
            } else {
              context.router.replaceNamed('/home');
            }
          }
        }
      } finally {
        loading.value = false;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome back!'),
      ),
      body: SafeArea(
        child: Body(
          bottom: ButtonBottomBar(
            children: [
              FilledButton(
                onPressed: loading.value ? null : onLoginPressed,
                child: loading.value
                    ? const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('Log in'),
              ),
            ],
          ),
          child: FormBuilder(
            key: globalKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Container(
                    decoration: ShapeDecoration(
                      color: theme.colorScheme.surfaceContainer,
                      shape: CircleBorder(),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Image.asset(
                        'assets/images/ginger-cat/logged-out.png',
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  FormBuilderTextField(
                    name: 'email',
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.email(),
                    ]),
                  ),
                  const SizedBox(height: 24),
                  FormBuilderTextField(
                    name: 'password',
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    onSubmitted: (_) => onLoginPressed(),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('Forgot password?'),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
