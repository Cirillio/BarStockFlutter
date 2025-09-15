// import 'package:bar_stock/features/stock/domain/entities/category.dart';
// import 'package:bar_stock/features/stock/domain/entities/item_unit.dart';
import 'package:bar_stock/features/stock/domain/entities/product_list_item.dart';
import 'package:bar_stock/features/stock/presentation/widgets/product_category_card.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:bar_stock/core/constants/state_status.dart';
import 'package:bar_stock/features/stock/presentation/states/category_list_state.dart';

class BuildProducts extends StatelessWidget {
  final BuildContext context;
  final CategoryListState state;
  final Future<void> Function() load;

  const BuildProducts({
    super.key,
    required this.context,
    required this.state,
    required this.load,
  });

  @override
  Widget build(BuildContext context) {
    if (state.itemsStatus == StateStatus.submitting) {
      return Column(
        spacing: 16,
        children: [
          ...[1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map(
            (_) => Basic(
              titleSpacing: 12,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              leading: const Avatar(initials: '').asSkeleton(),
              title: const Text(
                'Product title........................................',
              ),
              content: const Text('Product info..............................'),
            ).asSkeleton(),
          ),
        ],
      );
    }

    return Column(
      spacing: 12,
      children: [
        ...state.items.map(
          (item) => ProductCategoryCard(
            item: ProductListItem(
              id: item.id,
              name: item.name,
              imageUrl: item.imageUrl,
              category: item.category,
              qty: item.qty,
              unit: item.unit,
              minStock: item.minStock,
            ),
          ),
        ),
      ],
    ).withPadding(horizontal: 16, vertical: 12);
  }
}
