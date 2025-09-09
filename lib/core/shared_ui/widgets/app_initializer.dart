import 'package:bar_stock/di/auth/auth_provider.dart';
import 'package:bar_stock/di/profile/profile_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class AppInitializer extends ConsumerWidget {
  final Widget child;
  const AppInitializer({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authStateProvider, (_, next) {
      next.whenData((authState) {
        final session = authState.session;
        final profileNotifier = ref.read(profileControllerProvider.notifier);

        session != null
            ? profileNotifier.getProfile()
            : profileNotifier.clearProfile();
      });
    });
    return child;
  }
}
