import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SalesPage extends ConsumerWidget {
  const SalesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Button(
          style: ButtonStyle.card(size: ButtonSize.xSmall),
          child: Text('Sales Page'),
        ),
      ],
    );
  }
}
