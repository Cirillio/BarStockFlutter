import 'package:bar_stock/di/supabase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:bar_stock/di/auth/auth_provider.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:bar_stock/core/router/app_routes.dart';
import "package:bar_stock/core/shared_ui/widgets/app_navigation_bar.dart";
import 'package:shadcn_flutter/shadcn_flutter_extension.dart';
import 'package:bar_stock/core/shared_ui/widgets/layout_header.dart';

class RootScreen extends ConsumerWidget {
  final StatefulNavigationShell shell;
  const RootScreen({super.key, required this.shell});

  static final GlobalKey _navBarKey = GlobalKey();

  double _getNavBarHeight() {
    final renderBox =
        _navBarKey.currentContext?.findRenderObject() as RenderBox?;
    return renderBox?.size.height ?? 80; // fallback height
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final ctrl = ref.read(authControllerProvider.notifier);
    // final authState = ref.watch(authControllerProvider);
    // final router = GoRouter.of(context);
    final location = GoRouterState.of(context).matchedLocation;
    final title = AppRoutes.getTitle(location);
    final supa = ref.read(supabaseClientProvider);
    final session = supa.auth.currentSession;

    return Scaffold(
      floatingFooter: true,

      footers: [
        DecoratedBox(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: context.theme.colorScheme.mutedForeground.withAlpha(30),
                offset: const Offset(0, -1),
                blurRadius: 20,
                spreadRadius: 1,
              ),
            ],
          ),
          child: AppNavigationBar(key: _navBarKey, shell: shell),
        ),
      ],
      child: SafeArea(
        child: Column(
          children: [
            LayoutHeader(title: session?.user.email ?? "null"),

            Expanded(
              child: CustomScrollView(
                key: ValueKey(location),
                physics: const ClampingScrollPhysics(),
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.only(top: 16),
                    sliver: SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        children: [
                          Expanded(child: shell),
                          SizedBox(height: _getNavBarHeight()),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
