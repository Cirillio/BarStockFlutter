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
      spacing: 2,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
          child: Text(
            category.name,
            style: TextStyle(
              color: context.theme.colorScheme.foreground,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ).withMargin(vertical: 4, horizontal: 16),
        ),

        SizedBox(
          height: itemHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            itemCount: items.length + 1,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              if (index == items.length) {
                return SizedBox(
                  width: itemWidth,
                  child: Button(
                    style: const ButtonStyle(
                      variance: ButtonVariance.outline,
                      size: ButtonSize.small,
                    ),
                    onPressed: () {
                      // Navigate to category page
                      // GoRouter.of(context).push('/stock/category/${category.id}');
                    },
                    child: const Text('Смотреть все'),
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