import 'package:bar_stock/core/constants/state_status.dart';
import 'package:bar_stock/di/auth/auth_provider.dart';
import 'package:bar_stock/features/auth/presentation/login/login_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      child: Container(
        color: theme.colorScheme.primary,

        padding: const EdgeInsets.only(top: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.mutedForeground.withAlpha(125),
                      offset: Offset(0, 4),
                      blurRadius: 14,
                      spreadRadius: 2,
                    ),
                    BoxShadow(
                      color: theme.colorScheme.primaryForeground,
                      blurRadius: 1,
                      spreadRadius: 4,
                      blurStyle: BlurStyle.inner,
                    ),
                  ],
                ),
                child: SvgPicture.asset(
                  'assets/icons/appLogo.svg',

                  width: 72,
                  height: 72,
                ),
              ).withMargin(vertical: 32),
            ),
            Container(
              height: 2,
              color: theme.colorScheme.primaryForeground,
              child: authState.status != StateStatus.submitting
                  ? null
                  : LinearProgressIndicator(color: theme.colorScheme.primary),
            ),
            Expanded(child: const LoginPage()),
          ],
        ),
      ),
    );
  }
}
