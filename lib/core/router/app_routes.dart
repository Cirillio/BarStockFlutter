class AppRoutes {
  static const auth = '/auth';

  static const root = '/';

  static const stock = '/stock';
  static const sales = '/sales';
  static const analytics = '/analytics';

  static const profile = '/profile';

  static String getTitle(String branch) {
    switch (branch) {
      case AppRoutes.stock:
        return 'Stock';
      case AppRoutes.sales:
        return 'Sales';
      case AppRoutes.analytics:
        return 'Analytics';
      case AppRoutes.profile:
        return 'Profile';
      default:
        return '';
    }
  }
}
