import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:bar_stock/di/auth/auth_provider.dart';
import 'package:shadcn_flutter/shadcn_flutter_extension.dart';
import 'package:bar_stock/core/router/app_routes.dart';

class AppNavigationBar extends StatelessWidget {
  final bool expands = true;
  final NavigationLabelType labelType = NavigationLabelType.all;
  final NavigationBarAlignment alignment = NavigationBarAlignment.spaceAround;

  final bool customButtonStyle = true;
  final bool expanded = true;

  final StatefulNavigationShell shell;

  const AppNavigationBar({super.key, required this.shell});

  NavigationItem buildButton(String label, IconData icon) {
    return NavigationItem(
      style: customButtonStyle
          ? const ButtonStyle(
              size: ButtonSize.small,
              variance: ButtonVariance.muted,
              density: ButtonDensity.icon,
            )
          : null,
      selectedStyle: customButtonStyle
          ? const ButtonStyle(
              size: ButtonSize.small,
              variance: ButtonVariance.secondary,
              density: ButtonDensity.icon,
            )
          : null,
      label: Text(label),
      child: Icon(icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.colorScheme.secondary,
      child: NavigationBar(
        spacing: 0,
        labelType: labelType,
        expanded: expanded,
        expands: expands,
        onSelected: (index) {
          shell.goBranch(index);
        },
        index: shell.currentIndex,
        backgroundColor: context.theme.colorScheme.muted,
        children: [
          buildButton('Stock', LucideIcons.box),
          buildButton('Sales', LucideIcons.briefcaseBusiness),
          buildButton('Analytics', LucideIcons.chartPie),
          buildButton('Profile', LucideIcons.user),
        ],
      ),
    );
  }
}

class RootScreen extends ConsumerWidget {
  final StatefulNavigationShell shell;
  const RootScreen({super.key, required this.shell});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ctrl = ref.read(authControllerProvider.notifier);

    return Scaffold(
      headers: [
        AppBar(
          title: Text("Root"),
          trailing: [
            Button(
              style:
                  ButtonStyle(
                        size: ButtonSize.small,
                        variance: ButtonVariance.outline,
                        density: ButtonDensity.icon,
                      )
                      .withBorder(
                        border: Border.all(
                          color: context.theme.colorScheme.destructive,
                        ),
                      )
                      .withBackgroundColor(
                        color: context.theme.colorScheme.destructive.withAlpha(
                          25,
                        ),
                      ),
              onPressed: () {
                ctrl.logout();
              },
              child: Icon(
                LucideIcons.logOut,
                color: context.theme.colorScheme.destructive,
                size: 14,
              ),
            ),
          ],
        ),
        const Divider(),
      ],
      footers: [
        const Divider(),
        AppNavigationBar(shell: shell),
      ],
      child: shell,
    );
  }
}
