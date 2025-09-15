import 'package:bar_stock/di/analytics/analytics_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class DistributionPage extends HookConsumerWidget {
  const DistributionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(stockAnalyticsController);
    final controller = ref.read(stockAnalyticsController.notifier);

    Future.wait([Future.microtask(() async => await controller.initialize())]);
    return const Placeholder();
  }
}
