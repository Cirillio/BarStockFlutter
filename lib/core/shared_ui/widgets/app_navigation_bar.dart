import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:go_router/go_router.dart';

class AppNavigationBar extends StatelessWidget {
  final bool expands = true;
  final NavigationLabelType labelType = NavigationLabelType.none;
  final NavigationBarAlignment alignment = NavigationBarAlignment.spaceEvenly;

  final bool customButtonStyle = true;
  final bool expanded = false;

  final StatefulNavigationShell shell;

  const AppNavigationBar({super.key, required this.shell});

  void _navigateToRootOfBranch(int index) {
    switch (index) {
      case 0:
        // Stock tab - возвращаемся к /stock
        shell.goBranch(index, initialLocation: true);
        break;
      case 1:
        // Sales tab - возвращаемся к /sales
        shell.goBranch(index, initialLocation: true);
        break;
      case 2:
        // Analytics tab - возвращаемся к /analytics
        shell.goBranch(index, initialLocation: true);
        break;
    }
  }

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
          backgroundColor: null,
          surfaceBlur: 2.0,
          surfaceOpacity: 0.8,
          labelType: labelType,
          expanded: expanded,
          expands: expands,
          onSelected: (index) {
            if (shell.currentIndex == index) {
              // Если нажали на уже активную вкладку, возвращаемся к корневому маршруту
              _navigateToRootOfBranch(index);
            } else {
              // Обычное переключение между вкладками
              shell.goBranch(index);
            }
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
