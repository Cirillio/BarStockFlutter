import 'package:bar_stock/features/auth/presentation/login/login_state.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:bar_stock/core/constants/state_status.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:bar_stock/di/auth/auth_provider.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final state = ref.watch(authControllerProvider);
    final ctrl = ref.read(authControllerProvider.notifier);
    final email = useTextEditingController();
    final emailFocus = useFocusNode();
    final pass = useTextEditingController();
    final passFocus = useFocusNode();

    void submitLogin() {
      ctrl.login(email.text.trim(), pass.text.trim());
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      color: theme.colorScheme.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,

        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 2,
            children: [
              Text(
                'HELLO',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 28,
                  color: theme.colorScheme.primary,
                ),
              ),
              Text('Sign in to continue').xSmall.medium.muted,
            ],
          ),

          SizedBox(height: 24),

          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                style: const TextStyle(fontSize: 14),
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
                placeholder: const Text('your-email@example'),
                onTapOutside: (_) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
                features: [
                  InputFeature.clear(),
                  InputFeature.leading(
                    Icon(
                      LucideIcons.mail,
                      color:
                          state.errorOf(LoginField.email) != null ||
                              state.errorOf(LoginField.general) != null
                          ? theme.colorScheme.destructive
                          : null,
                    ),
                  ),
                ],
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                enabled: state.status != StateStatus.submitting,
                focusNode: emailFocus,
                controller: email,
                textInputAction: TextInputAction.next,
                onSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(passFocus),
                onEditingComplete: () =>
                    FocusScope.of(context).requestFocus(passFocus),
              ),

              SizedBox(
                height: 24,
                child: Text(
                  state.errorOf(LoginField.email) != null
                      ? state.errorOf(LoginField.email)!
                      : "",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: theme.colorScheme.destructive,
                    fontSize: 14,
                  ),
                ).withPadding(top: 2),
              ),

              TextField(
                style: const TextStyle(fontSize: 14),
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
                placeholder: const Text('••••••'),
                onTapOutside: (_) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
                features: [
                  InputFeature.passwordToggle(),
                  InputFeature.leading(
                    Icon(
                      LucideIcons.lock,
                      color:
                          state.errorOf(LoginField.password) != null ||
                              state.errorOf(LoginField.general) != null
                          ? theme.colorScheme.destructive
                          : null,
                    ),
                  ),
                ],
                focusNode: passFocus,
                enabled: state.status != StateStatus.submitting,
                textInputAction: TextInputAction.done,
                controller: pass,
                onSubmitted: (_) => submitLogin(),
                onEditingComplete: submitLogin,
              ),

              SizedBox(
                height: 24,
                child: Text(
                  state.errorOf(LoginField.password) != null
                      ? state.errorOf(LoginField.password)!
                      : "",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: theme.colorScheme.destructive,
                    fontSize: 14,
                  ),
                ).withPadding(top: 2),
              ),

              const SizedBox(height: 16),

              Button(
                enabled: state.status != StateStatus.submitting,
                onPressed: submitLogin,
                style: ButtonVariance.primary,
                child: Text('Login').xSmall,
              ),

              if (state.errorOf(LoginField.general) != null)
                Text(
                  state.errorOf(LoginField.general)!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: theme.colorScheme.destructive,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ).withMargin(top: 16),

              Row(
                spacing: 16,
                children: [
                  const Expanded(flex: 2, child: Divider(thickness: 1)),
                  Text(
                    'or use another method',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: theme.colorScheme.accentForeground),
                  ).xSmall,
                  const Expanded(flex: 2, child: Divider(thickness: 1)),
                ],
              ).withMargin(vertical: 24),
              Flex(
                spacing: 16,
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Button.outline(
                    child: SvgPicture.asset(
                      'assets/icons/google.svg',
                      width: 20,
                      height: 20,
                    ),
                    onPressed: () {},
                  ),
                  Button.outline(
                    child: SvgPicture.asset(
                      'assets/icons/discord.svg',
                      width: 20,
                      height: 20,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),

          Flexible(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Button(
                style: ButtonVariance.outline,
                onPressed: () {},
                child: const Text('Forgot password? Reset').xSmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
