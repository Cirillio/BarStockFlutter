import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter/shadcn_flutter_extension.dart';

class DestructiveButtonOutline extends StatelessWidget {
  final Function onPressed;
  final bool isLoading;
  final IconData? icon;
  final String? label;

  const DestructiveButtonOutline({
    super.key,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Button(
      enabled: !isLoading,
      style:
          ButtonStyle(
                size: ButtonSize.small,
                variance: ButtonVariance.outline,
                density: ButtonDensity.icon,
              )
              .withBorder(
                border: Border.all(
                  color: context.theme.colorScheme.destructive,
                ),
              )
              .withBackgroundColor(
                color: context.theme.colorScheme.destructive.withAlpha(25),
              ),
      onPressed: () => onPressed(),
      leading: !isLoading
          ? Icon(icon, color: context.theme.colorScheme.destructive, size: 14)
          : CircularProgressIndicator(size: 14),
      child: Text(
        "$label",
        style: TextStyle(color: context.theme.colorScheme.destructive),
      ),
    );
  }
}
