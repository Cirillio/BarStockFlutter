import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'core/router/router.dart';
import 'package:bar_stock/screen/login_screen.dart';

class BarStockApp extends StatelessWidget {
  const BarStockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadcnApp(
      title: 'Bar Stock',
      home: Column(children: [const LoginScreen()]),
      theme: ThemeData(
        colorScheme: ColorSchemes.lightRed(),
        radius: 0.5,
        surfaceBlur: 2,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorSchemes.darkRed(),
        radius: 0.5,
        surfaceBlur: 2,
      ),
    );
  }
}
