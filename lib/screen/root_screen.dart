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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final ctrl = ref.read(authControllerProvider.notifier);
    // final authState = ref.watch(authControllerProvider);
    // final router = GoRouter.of(context);
    final location = GoRouterState.of(context).matchedLocation;
    final title = AppRoutes.getTitle(location);

    return Scaffold(
      resizeToAvoidBottomInset: true,

      footers: [
        DecoratedBox(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: context.theme.colorScheme.mutedForeground.withAlpha(30),
                offset: Offset(0, -1),
                blurRadius: 20,
                spreadRadius: 1,
              ),
            ],
          ),
          child: AppNavigationBar(shell: shell),
        ),
      ],
      child: SafeArea(
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (notification) {
            notification.disallowIndicator();
            return true;
          },
          child: Column(
            children: [
              LayoutHeader(title: title),
              Expanded(child: shell),
            ],
          ),
        ),
      ),
    );
  }
}
