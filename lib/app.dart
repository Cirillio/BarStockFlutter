import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:bar_stock/core/router/router.dart';

class BarStockApp extends ConsumerWidget {
  const BarStockApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return ShadcnApp.router(
      title: 'Bar Stock',
      routerConfig: router,
      theme: ThemeData(
        typography: Typography.geist(sans: TextStyle(fontFamily: 'Geist')),
        colorScheme: ColorSchemes.lightRose(),
        radius: 0.25,
        surfaceBlur: 2,
      ),
      darkTheme: ThemeData(
        typography: Typography.geist(sans: TextStyle(fontFamily: 'Geist')),
        colorScheme: ColorSchemes.darkRed(),
        radius: 0.25,
        surfaceBlur: 2,
      ),
    );
  }
}
