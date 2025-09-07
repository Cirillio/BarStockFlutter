import 'package:bar_stock/features/stock/domain/types/stock_typedef.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:bar_stock/features/stock/presentation/widgets/product_category_section.dart';
import 'package:shadcn_flutter/shadcn_flutter_extension.dart';

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...categories.map((category) {
          final items = categoriesItemList[category]!;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ProductCategorySection(category: category, items: items),
          );
        }),
        Center(
          child: Button(
            onPressed: () {},
            style: const ButtonStyle(
              variance: ButtonStyle.outline(),
              size: ButtonSize.small,
              density: ButtonDensity.comfortable,
            ),
            child: Text(
              'Показать все товары',
              style: TextStyle(color: context.theme.colorScheme.foreground),
            ),
          ).withMargin(vertical: 8, horizontal: 12),
        ),
      ],
    );
  }
}
