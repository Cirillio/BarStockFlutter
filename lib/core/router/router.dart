import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import '../../screen/login_screen.dart';
import '../../screen/register_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _authNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'auth');
// final _mainNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'main');

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  routes: [
    // Маршрут аутентификации
    GoRoute(path: '/auth', redirect: (_, __) => '/auth/login'),
    GoRoute(
      path: '/auth/login',
      builder: (_, __) => const LoginScreen(),
      parentNavigatorKey: _authNavigatorKey,
    ),
    GoRoute(
      path: '/auth/login',
      builder: (_, __) => const RegisterScreen(),
      parentNavigatorKey: _authNavigatorKey,
    ),
    // Основной маршрут с навигационной панелью
  ],
);
