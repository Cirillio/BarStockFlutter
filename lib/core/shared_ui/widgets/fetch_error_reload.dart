import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter/shadcn_flutter_extension.dart';

class FetchErrorReload extends StatefulWidget {
  const FetchErrorReload({
    super.key,
    this.title = "Fetch Error. Try again.",
    this.errors = const {},
    required this.onReload,
  });

  final String title;
  final Map<String, String> errors;
  final VoidCallback onReload;

  @override
  State<FetchErrorReload> createState() => _FetchErrorReloadState();
}

class _FetchErrorReloadState extends State<FetchErrorReload> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          LucideIcons.circleAlert,
          size: 32,
          color: context.theme.colorScheme.destructive,
        ),
        const SizedBox(height: 16),
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 20,
            color: context.theme.colorScheme.destructive,
          ),
        ),
        const SizedBox(height: 8),
        Accordion(
          items: [
            AccordionItem(
              trigger: AccordionTrigger(
                child: const Center(
                  child: Text('See details', style: TextStyle(fontSize: 16)),
                ),
              ),
              content: Column(
                children: [
                  ...widget.errors.values.map((error) {
                    return Text(
                      error,
                      style: TextStyle(
                        fontSize: 12,
                        color: context.theme.colorScheme.destructive,
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Button(
          style: ButtonStyle(
            variance: const ButtonStyle.destructive(size: ButtonSize.small),
          ),
          onPressed: widget.onReload, // используем widget.onReload
          child: const Text(
            'Повторить',
          ).withMargin(vertical: 6, horizontal: 64),
        ),
      ],
    );
  }
}
