import 'package:bar_stock/core/shared_ui/widgets/item_card.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:bar_stock/features/analytics/data/types/analytics_section.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        ...AnalyticsSection.values.map(
          (section) => ItemCard(
            goTo: "/analytics/${section.route}",
            child: Row(
              children: [
                Icon(section.icon, size: 32),
                const SizedBox(width: 12),
                Text(section.route, style: TextStyle(fontSize: 26)),
              ],
            ).withMargin(horizontal: 12, vertical: 16),
          ),
        ),
      ],
    ).withPadding(horizontal: 16);
  }
}
