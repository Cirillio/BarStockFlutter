import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter_extension.dart';

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
        ],
      ),
    );
  }
}
