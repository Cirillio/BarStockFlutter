import 'package:bar_stock/di/auth/auth_provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final state = ref.watch(loginControllerProvider);
    final ctrl = ref.read(loginControllerProvider.notifier);
    final email = useTextEditingController();
    final pass = useTextEditingController();

    return Container(
      padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      color: theme.colorScheme.background,
      child: Column(
        children: [
          Column(
            spacing: 8,
            children: [
              Text(
                'Login Now',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.primary,
                ),
              ),
              Text('Please login to continue using our app').xSmall.muted,
            ],
          ).withMargin(vertical: 96),

          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                style: TextStyle(fontSize: 18),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                placeholder: Text('Enter your email'),
                onTapOutside: (_) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
                controller: email,
              ),
              const SizedBox(height: 16),

              TextField(
                features: [
                  InputFeature.passwordToggle(mode: PasswordPeekMode.toggle),
                ],
                style: TextStyle(fontSize: 18),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                placeholder: Text('Enter your password'),
                onTapOutside: (_) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
                controller: pass,
              ),
              Text(
                'Forgot password?',
              ).xSmall.muted.withPadding(left: 8, top: 8),
              const SizedBox(height: 32),

              if (state.error != null)
                Text(
                  state.error!,
                  style: TextStyle(color: theme.colorScheme.destructive),
                ).withPadding(bottom: 16),

              Button(
                style: ButtonVariance.primary,
                onPressed: state.isLoading
                    ? null
                    : () => ctrl.login(email.text.trim(), pass.text.trim()),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (state.isLoading)
                      const CircularProgressIndicator(size: 16),
                    Text(
                      'Sign In',
                      style: TextStyle(
                        color: state.isLoading ? theme.colorScheme.muted : null,
                      ),
                    ),
                  ],
                ).withMargin(vertical: 4),
              ),

              Row(
                spacing: 16,
                children: [
                  Expanded(flex: 2, child: const Divider(thickness: 1)),
                  Text(
                    'or continue with',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: theme.colorScheme.accentForeground),
                  ),
                  Expanded(flex: 2, child: const Divider(thickness: 1)),
                ],
              ).withMargin(vertical: 32),
              Flex(
                spacing: 16,
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    child: Button.outline(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 8,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/google.svg',
                            width: 24,
                            height: 24,
                          ),
                          Text('Google').withMargin(vertical: 8),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Expanded(
                    child: Button.outline(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 8,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/discord.svg',
                            width: 24,
                            height: 24,
                          ),
                          Text('Discord').withMargin(vertical: 8),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
          Expanded(child: Container()),
          Button(
            style: ButtonVariance.outline,
            onPressed: () {},
            child: Text('Still no account? Sign Up'),
          ),
        ],
      ),
    );
  }
}
