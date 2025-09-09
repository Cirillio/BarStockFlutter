import 'package:bar_stock/core/router/app_routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter_extension.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bar_stock/di/auth/auth_provider.dart';
import 'package:bar_stock/core/constants/state_status.dart';

class LayoutHeader extends ConsumerWidget {
  final String title;
  const LayoutHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = Supabase.instance.client.auth;
    final ctrl = ref.read(authControllerProvider.notifier);
    final authState = ref.watch(authControllerProvider);
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 6,
              children: [
                Button(
                  onPressed: () {
                    GoRouter.of(context).push(AppRoutes.profile);
                  },
                  style: const ButtonStyle(
                    shape: ButtonShape.circle,
                    variance: ButtonVariance.primary,
                    density: ButtonDensity.icon,
                  ),
                  child: Icon(LucideIcons.user, size: 16),
                ),
                OutlineBadge(
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            Row(
              spacing: 6,
              children: [
                Button(
                  onPressed: () {},
                  style: const ButtonStyle(
                    shape: ButtonShape.circle,
                    variance: ButtonVariance.outline,
                    density: ButtonDensity.icon,
                  ),
                  child: Icon(
                    AppRoutes.getIcon(
                      GoRouterState.of(context).matchedLocation,
                    ),
                    size: 16,
                  ),
                ),

                Button(
                  onPressed: () {},
                  style: const ButtonStyle(
                    shape: ButtonShape.circle,
                    variance: ButtonVariance.outline,
                    density: ButtonDensity.icon,
                  ),
                  child: Icon(LucideIcons.settings, size: 16),
                ),
              ],
            ),
          ],
        ).withPadding(horizontal: 16, vertical: 8),
        const Divider(),
      ],
    );
  }
}
