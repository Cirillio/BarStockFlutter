import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter_extension.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import "package:bar_stock/core/shared_ui/widgets/destructive_button_outline.dart";
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bar_stock/di/auth/auth_provider.dart';
import 'package:bar_stock/core/constants/state_status.dart';

class AppHeaderBar extends ConsumerWidget {
  final String title;
  const AppHeaderBar({super.key, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      title: Text("Bar Stock | $title"),
      trailing: [
        Button(
          style: ButtonStyle(
            size: ButtonSize.small,
            variance: ButtonStyle.ghost(),
            density: ButtonDensity.icon,
          ),
          child: Icon(
            LucideIcons.menu,
            color: context.theme.colorScheme.primary,
            size: 24,
          ),
          onPressed: () {
            openSheet(
              barrierColor: context.theme.colorScheme.muted.withAlpha(175),
              context: context,
              builder: (context) => buildSheet(context),
              position: OverlayPosition.left,
            );
          },
        ),
      ],
    );
  }
}

Widget buildSheet(BuildContext context) {
  return Consumer(
    builder: (context, ref, child) {
      final auth = Supabase.instance.client.auth;
      final ctrl = ref.read(authControllerProvider.notifier);
      final authState = ref.watch(authControllerProvider);
      return Container(
        color: context.theme.colorScheme.card,
        constraints: const BoxConstraints(maxWidth: 280),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              constraints: const BoxConstraints(minHeight: 120),
              color: context.theme.colorScheme.primary,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  auth.currentUser?.id ?? "",
                  style: TextStyle(
                    color: context.theme.colorScheme.primaryForeground,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 12,
                      children: [
                        Text(
                          "Menu",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: context.theme.colorScheme.primary,
                          ),
                        ),
                        Divider(),
                        Button(
                          style: ButtonStyle(
                            variance: ButtonStyle.menu(),
                            size: ButtonSize.normal,
                            density: ButtonDensity.icon,
                          ),
                          leading: Icon(
                            LucideIcons.user,
                            size: 20,
                          ).withMargin(left: 4),
                          onPressed: () {},
                          child: Text(
                            "Profile",
                            style: TextStyle(fontSize: 16),
                          ).withMargin(vertical: 4),
                        ),
                        Button(
                          style: ButtonStyle(
                            variance: ButtonStyle.menu(),
                            size: ButtonSize.normal,
                            density: ButtonDensity.icon,
                          ),
                          leading: Icon(
                            LucideIcons.settings,
                            size: 20,
                          ).withMargin(left: 4),
                          onPressed: () {},
                          child: Text(
                            "Settings",
                            style: TextStyle(fontSize: 16),
                          ).withMargin(vertical: 4),
                        ),
                        Divider(),
                      ],
                    ),
                    DestructiveButtonOutline(
                      onPressed: ctrl.logout,
                      label: "Logout",
                      icon: LucideIcons.logOut,
                      isLoading: authState.status == StateStatus.submitting,
                    ).withMargin(bottom: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
