import 'package:bar_stock/features/stock/domain/types/stock_typedef.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:bar_stock/features/stock/presentation/widgets/product_category_section.dart';

class CategoriesItemList extends ConsumerWidget {
  const CategoriesItemList({super.key, required this.categoriesItemList});

  final ProductListByCategory categoriesItemList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (categoriesItemList.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(LucideIcons.packageOpen, size: 48),
            SizedBox(height: 16),
            Text('Товары не найдены'),
          ],
        ),
      );
    }

    final categories = categoriesItemList.keys.toList();

    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (notification) {
        notification.disallowIndicator();
        return true;
      },
      child: ListView.separated(
        itemCount: categories.length,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        padding: const EdgeInsets.symmetric(vertical: 12),
        itemBuilder: (context, index) {
          final category = categories[index];
          final items = categoriesItemList[category]!;
          return ProductCategorySection(category: category, items: items);
        },
      ),
    );
  }
}
