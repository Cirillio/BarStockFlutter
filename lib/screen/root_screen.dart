import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:bar_stock/di/auth/auth_provider.dart';

class RootScreen extends ConsumerWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ctrl = ref.read(authControllerProvider.notifier);

    return Scaffold(
      headers: [
        AppBar(title: const Text("Root Screen")),
        const Divider(),
      ],
      child: Center(
        child: Button(
          style: ButtonVariance.primary,
          onPressed: () {
            ctrl.logout();
          },
          child: const Text("Logout"),
        ),
      ),
    );
  }
}
