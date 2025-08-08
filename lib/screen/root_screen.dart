import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class RootScreen extends StatefulWidget {
  final StatefulNavigationShell shell;

  const RootScreen({super.key, required this.shell});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  bool expanded = false;

  final List<_NavItem> sideNavItems = [
    _NavItem(icon: Icon(LucideIcons.house), label: 'Coins', route: '/'),
    _NavItem(
      icon: Icon(LucideIcons.settings),
      label: 'Settings',
      route: '/settings',
    ),
  ];

  void _onSideNavSelect(int index) {
    if (index == 2) {
      return;
    }

    final item = sideNavItems[index];
    final branchMap = {'/': 0, '/settings': 3};
    final targetIndex = branchMap[item.route];
    if (targetIndex != null) {
      widget.shell.goBranch(targetIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentIndex = widget.shell.currentIndex;

    return Container(
      color: theme.colorScheme.background,
      child: Column(
        children: [
          AppBar(
            header: const Text('cript mini-app'),
            title: const Text('Crypto Tracker'),
            leading: [
              OutlineButton(
                size: ButtonSize.small,
                density: ButtonDensity.icon,
                onPressed: () => {},
                child: const Icon(LucideIcons.arrowLeft),
              ),
            ],
            trailing: [
              OutlineButton(
                density: ButtonDensity.icon,
                onPressed: () => context.go('/portfolio'),
                child: const Icon(LucideIcons.squareUser),
              ),
              OutlineButton(
                density: ButtonDensity.icon,
                onPressed: () => context.go('/favourites'),
                child: const Icon(LucideIcons.bookMarked),
              ),
            ],
          ),
          Expanded(
            child: Row(
              spacing: 4,
              children: [
                Card(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurStyle: BlurStyle.normal,
                      offset: const Offset(0, 3),
                      spreadRadius: 1,
                      blurRadius: 3,
                    ),
                  ],
                  padding: const EdgeInsets.all(0),
                  clipBehavior: Clip.antiAlias,
                  child: NavigationRail(
                    padding: const EdgeInsets.all(4),
                    backgroundColor: theme.colorScheme.popover,
                    labelType: expanded
                        ? NavigationLabelType.expanded
                        : NavigationLabelType.none,
                    labelPosition: NavigationLabelPosition.end,
                    alignment: NavigationRailAlignment.start,
                    expanded: expanded,
                    index: currentIndex == 3 ? 1 : 0,
                    onSelected: _onSideNavSelect,
                    children: [
                      NavigationButton(
                        alignment: Alignment.centerLeft,
                        label: const Text('Menu').textSmall,
                        onPressed: () => setState(() => expanded = !expanded),
                        child: const Icon(Icons.menu),
                      ),
                      const NavigationDivider(),
                      for (final item in sideNavItems)
                        NavigationItem(
                          alignment: Alignment.centerLeft,
                          label: Text(item.label).textSmall,
                          selectedStyle: const ButtonStyle.primaryIcon(),
                          child: item.icon,
                        ),
                      const NavigationDivider(),
                      NavigationItem(
                        alignment: Alignment.centerLeft,
                        label: Text('Log out').textSmall,
                        selectedStyle: const ButtonStyle.primaryIcon(),
                        child: Icon(LucideIcons.logOut),
                      ),
                    ],
                  ),
                ),
                Expanded(child: widget.shell),
              ],
            ).withPadding(all: 4),
          ),
        ],
      ),
    );
  }
}

class _NavItem {
  final Icon icon;
  final String label;
  final String route;

  _NavItem({required this.icon, required this.label, required this.route});
}
