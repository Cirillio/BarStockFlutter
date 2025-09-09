import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter/shadcn_flutter_extension.dart';
import 'package:go_router/go_router.dart';

class GoBackButton extends StatelessWidget {
  const GoBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: GoRouter.of(context).pop,
      style: const ButtonStyle(
        variance: ButtonVariance.outline,
        shape: ButtonShape.circle,
        density: ButtonDensity.icon,
      ),
      child: Icon(
        LucideIcons.chevronLeft,
        size: 16,
        color: context.theme.colorScheme.primary,
      ),
    );
  }
}
