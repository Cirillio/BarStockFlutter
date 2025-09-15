import 'package:bar_stock/features/analytics/presentation/distribution_page.dart';
import 'package:bar_stock/features/profile/presentation/page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:bar_stock/screen/auth_screen.dart';
import 'package:bar_stock/screen/root_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bar_stock/core/router/router_listenable.dart';
import 'package:bar_stock/core/router/app_routes.dart';
import 'package:bar_stock/features/stock/presentation/pages/page.dart';
import 'package:bar_stock/features/stock/presentation/pages/category/page.dart';
import 'package:bar_stock/features/analytics/presentation/page.dart';
import 'package:bar_stock/features/sales/presentation/page.dart';
import 'package:bar_stock/features/analytics/data/types/analytics_section.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final auth = Supabase.instance.client.auth;

  final refresh = AuthListenable(auth.onAuthStateChange);
  ref.onDispose(refresh.dispose);

  return GoRouter(
    initialLocation: auth.currentSession != null
        ? AppRoutes.stock
        : AppRoutes.auth,
    refreshListenable: refresh,
    routes: [
      GoRoute(
        path: AppRoutes.auth,
        name: 'auth',
        builder: (context, state) => const AuthScreen(),
      ),

      GoRoute(
        path: AppRoutes.profile,
        name: 'profile',
        builder: (context, state) => const ProfilePage(),
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => RootScreen(shell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.stock,
                builder: (context, state) => const StockPage(),
                routes: [
                  GoRoute(
                    path: 'category/:id',
                    builder: (context, state) {
                      final categoryId = int.parse(state.pathParameters['id']!);
                      return CategoryPage(categoryId: categoryId);
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.sales,
                builder: (context, state) => const SalesPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.analytics,
                builder: (context, state) => const AnalyticsPage(),
                routes: [
                  GoRoute(
                    path: AnalyticsSection.stockLevels.route,
                    builder: (context, state) => const DistributionPage(),
                  ),
                  GoRoute(
                    path: AnalyticsSection.criticalStock.route,
                    builder: (context, state) => const DistributionPage(),
                  ),
                  GoRoute(
                    path: AnalyticsSection.inventoryValue.route,
                    builder: (context, state) => const DistributionPage(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],

    redirect: (context, state) {
      final isLoggedIn = auth.currentSession != null;
      final isAuthPage = state.matchedLocation == AppRoutes.auth;

      if (isLoggedIn && isAuthPage) {
        return AppRoutes.stock;
      }

      if (!isLoggedIn && !isAuthPage) {
        return AppRoutes.auth;
      }

      return null;
    },
  );
});
