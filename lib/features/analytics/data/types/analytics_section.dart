import 'package:shadcn_flutter/shadcn_flutter.dart';

enum AnalyticsSection {
  stockLevels('Остатки', 'stock-levels', LucideIcons.chartPie),
  criticalStock('Критические остатки', 'critical', LucideIcons.monitorX),
  inventoryValue('Стоимость инвентаря', 'value', LucideIcons.packageSearch);

  const AnalyticsSection(this.title, this.route, this.icon);

  final String title;
  final String route;
  final IconData icon;
}
