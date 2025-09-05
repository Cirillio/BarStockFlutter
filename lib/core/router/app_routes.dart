import 'package:shadcn_flutter/shadcn_flutter.dart';

class AppRoutes {
  static const auth = '/auth';

  static const root = '/';

  static const stock = '/stock';
  static const sales = '/sales';
  static const analytics = '/analytics';

  static String getTitle(String branch) {
    switch (branch) {
      case AppRoutes.stock:
        return 'Stock';
      case AppRoutes.sales:
        return 'Sales';
      case AppRoutes.analytics:
        return 'Analytics';

      default:
        return '';
    }
  }

  static IconData getIcon(String branch) {
    switch (branch) {
      case AppRoutes.stock:
        return LucideIcons.box;
      case AppRoutes.sales:
        return LucideIcons.briefcaseBusiness;
      case AppRoutes.analytics:
        return LucideIcons.chartPie;
      default:
        return LucideIcons.image;
    }
  }
}
