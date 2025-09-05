import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter_extension.dart';

class AppNavigationBar extends StatelessWidget {
  final bool expands = true;
  final NavigationLabelType labelType = NavigationLabelType.tooltip;
  final NavigationBarAlignment alignment = NavigationBarAlignment.spaceEvenly;

  final bool customButtonStyle = true;
  final bool expanded = false;

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
              variance: ButtonVariance.link,
              density: ButtonDensity.icon,
            )
          : null,
      label: Text(label),
      child: Icon(icon, size: 24),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        NavigationBar(
          labelType: labelType,
          expanded: expanded,
          expands: expands,
          onSelected: (index) {
            shell.goBranch(index);
          },
          index: shell.currentIndex,
          children: [
            buildButton('Stock', LucideIcons.box),
            buildButton('Sales', LucideIcons.briefcaseBusiness),
            buildButton('Analytics', LucideIcons.chartPie),
          ],
        ),
      ],
    );
  }
}
