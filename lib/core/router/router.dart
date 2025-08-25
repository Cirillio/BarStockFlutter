import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:bar_stock/screen/auth_screen.dart';
import 'package:bar_stock/screen/root_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bar_stock/core/router/router_listenable.dart';
import 'package:bar_stock/core/router/app_routes.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final auth = Supabase.instance.client.auth;

  final refresh = AuthListenable(auth.onAuthStateChange);
  ref.onDispose(refresh.dispose);

  return GoRouter(
    initialLocation: auth.currentSession != null
        ? AppRoutes.root
        : AppRoutes.auth,
    refreshListenable: refresh,
    routes: [
      GoRoute(
        path: AppRoutes.auth,
        name: 'auth',
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: AppRoutes.root,
        name: 'root',
        builder: (context, state) => const RootScreen(),
      ),
    ],

    redirect: (context, state) {
      final isLoggedIn = auth.currentSession != null;
      final isAuthPage = state.matchedLocation == AppRoutes.auth;

      if (isLoggedIn && isAuthPage) {
        return AppRoutes.root;
      }

      if (!isLoggedIn && !isAuthPage) {
        return AppRoutes.auth;
      }

      return null;
    },
  );
});
