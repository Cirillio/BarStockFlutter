import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'core/router/router.dart';

class BarStockApp extends StatelessWidget {
  const BarStockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadcnApp.router(
      title: 'Bar Stock',
      theme: ThemeData(
        colorScheme: ColorSchemes.lightViolet(),
        radius: 0.5,
        surfaceBlur: 2,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorSchemes.darkGreen(),
        radius: 0.5,
        surfaceBlur: 2,
      ),
      routerConfig: router,
    );
  }
}
