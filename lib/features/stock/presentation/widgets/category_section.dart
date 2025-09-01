import 'package:bar_stock/features/stock/domain/entities/product_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter/shadcn_flutter_extension.dart';
import 'package:bar_stock/features/stock/presentation/widgets/item_card.dart';

class CategorySection extends ConsumerWidget {
  const CategorySection({
    super.key,
    required this.categoryTitle,
    required this.drinks,
  });

  final String categoryTitle;
  final List<ProductItem> drinks;

  static const double itemWidth = 160;
  static const double itemHeight = 240;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      spacing: 4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: context.theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 2,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                LucideIcons.fileBox,
                size: 14,
                color: context.theme.colorScheme.primaryForeground,
              ),
              Text(
                categoryTitle,
                style: TextStyle(
                  color: context.theme.colorScheme.primaryForeground,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ).withMargin(vertical: 4, horizontal: 8),
        ).withMargin(left: 16),

        SizedBox(
          height: itemHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            itemCount: drinks.length + 1,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              if (index == drinks.length) {
                return SizedBox(
                  width: itemWidth,
                  child: Button(
                    style: const ButtonStyle(
                      variance: ButtonVariance.outline,
                      size: ButtonSize.small,
                    ),
                    onPressed: () {},
                    child: const Text('Смотреть все'),
                  ),
                );
              }

              final item = drinks[index];
              return SizedBox(
                width: itemWidth,
                child: ItemCard(item: item),
              );
            },
          ),
        ),
      ],
    );
  }
}
