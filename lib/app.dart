import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'core/router/router.dart';
import 'package:bar_stock/screen/login_screen.dart';

class BarStockApp extends ConsumerWidget {
  const BarStockApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ShadcnApp(
      title: 'Bar Stock',
      home: Column(children: [const LoginScreen()]),
      theme: ThemeData(
        typography: Typography.geist(sans: TextStyle(fontFamily: 'Geist')),
        colorScheme: ColorSchemes.lightRose(),
        radius: 0.5,
        surfaceBlur: 2,
      ),
      darkTheme: ThemeData(
        typography: Typography.geist(sans: TextStyle(fontFamily: 'Geist')),
        colorScheme: ColorSchemes.darkRed(),
        radius: 0.5,
        surfaceBlur: 2,
      ),
    );
  }
}
