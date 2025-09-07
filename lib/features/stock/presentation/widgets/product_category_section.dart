import 'package:bar_stock/core/shared_ui/widgets/item_card.dart';
import 'package:bar_stock/features/stock/domain/entities/category.dart';
import 'package:bar_stock/features/stock/domain/entities/product_list_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter/shadcn_flutter_extension.dart';
import 'package:bar_stock/features/stock/presentation/widgets/product_list_item_card.dart';

class ProductCategorySection extends ConsumerWidget {
  const ProductCategorySection({
    super.key,
    required this.category,
    required this.items,
  });

  final Category category;
  final List<ProductListItem> items;

  static const double itemWidth = 160;
  static const double itemHeight = 240;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        OutlineBadge(
          child: Text(category.name, style: const TextStyle(fontSize: 16)),
        ).withMargin(horizontal: 16),
        SizedBox(
          height: itemHeight,
          child: ListView.separated(
            key: ValueKey(DateTime.now()),
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            itemCount: items.length + 1,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              if (index == items.length) {
                return SizedBox(
                  width: itemWidth,
                  child: ItemCard(
                    goTo: '/stock/category/${category.id}',
                    child: Center(
                      child: Icon(
                        LucideIcons.grip,
                        size: 24,
                        color: context.theme.colorScheme.primary.withAlpha(100),
                      ),
                    ),
                  ),
                );
              }

              final item = items[index];
              return SizedBox(
                width: itemWidth,
                child: ProductListItemCard(item: item),
              );
            },
          ),
        ),
      ],
    );
  }
}
