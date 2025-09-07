import 'package:bar_stock/core/shared_ui/widgets/item_card.dart';
import 'package:bar_stock/features/stock/domain/entities/category.dart';
import 'package:bar_stock/features/stock/domain/entities/item_unit.dart';
import 'package:bar_stock/features/stock/domain/entities/product_list_item.dart';
import 'package:bar_stock/features/stock/presentation/widgets/product_category_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:bar_stock/core/constants/state_status.dart';
import 'package:bar_stock/features/stock/presentation/states/category_list_state.dart';
import 'package:shadcn_flutter/shadcn_flutter_extension.dart';

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
        spacing: 24,
        children: [
          Basic(
            titleSpacing: 12,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            leading: Avatar(initials: '').asSkeleton(),
            title: Text('Product title.........................'),
            content: Text('Product info.....................'),
          ).asSkeleton(),
          Basic(
            titleSpacing: 12,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            leading: Avatar(initials: '').asSkeleton(),
            title: Text('Product title.........................'),
            content: Text('Product info.....................'),
          ).asSkeleton(),
          Basic(
            titleSpacing: 12,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            leading: Avatar(initials: '').asSkeleton(),
            title: Text('Product title.........................'),
            content: Text('Product info.....................'),
          ).asSkeleton(),
        ],
      );
    }

    return Column(
      spacing: 12,
      children: [
        ProductCategoryCard(
          item: ProductListItem(
            id: "2231dfd",
            name: "Some wine",
            imageUrl:
                "https://winemore.ru/upload/iblock/31e/r2i00vytkwnj0h48fg0eaa1ksi769yvc/1720767003-51FCsYfdPL.jpg",
            category: Category(id: 1, name: "Wine", iconUrl: ""),
            qty: 14,
            unit: ItemUnit.bottle,
            minStock: 20,
          ),
        ),
        ProductCategoryCard(
          item: ProductListItem(
            id: "2231dfd",
            name: "Some wine",
            imageUrl:
                "https://winemore.ru/upload/iblock/31e/r2i00vytkwnj0h48fg0eaa1ksi769yvc/1720767003-51FCsYfdPL.jpg",
            category: Category(id: 1, name: "Wine", iconUrl: ""),
            qty: 14,
            unit: ItemUnit.bottle,
            minStock: 20,
          ),
        ),
        ProductCategoryCard(
          item: ProductListItem(
            id: "2231dfd",
            name: "Some wine",
            imageUrl:
                "https://winemore.ru/upload/iblock/31e/r2i00vytkwnj0h48fg0eaa1ksi769yvc/1720767003-51FCsYfdPL.jpg",
            category: Category(id: 1, name: "Wine", iconUrl: ""),
            qty: 14,
            unit: ItemUnit.bottle,
            minStock: 20,
          ),
        ),
        ProductCategoryCard(
          item: ProductListItem(
            id: "2231dfd",
            name: "Some wine",
            imageUrl:
                "https://winemore.ru/upload/iblock/31e/r2i00vytkwnj0h48fg0eaa1ksi769yvc/1720767003-51FCsYfdPL.jpg",
            category: Category(id: 1, name: "Wine", iconUrl: ""),
            qty: 14,
            unit: ItemUnit.bottle,
            minStock: 20,
          ),
        ),
        ProductCategoryCard(
          item: ProductListItem(
            id: "2231dfd",
            name: "Some wine",
            imageUrl:
                "https://winemore.ru/upload/iblock/31e/r2i00vytkwnj0h48fg0eaa1ksi769yvc/1720767003-51FCsYfdPL.jpg",
            category: Category(id: 1, name: "Wine", iconUrl: ""),
            qty: 14,
            unit: ItemUnit.bottle,
            minStock: 20,
          ),
        ),
        ProductCategoryCard(
          item: ProductListItem(
            id: "2231dfd",
            name: "Some wine",
            imageUrl:
                "https://winemore.ru/upload/iblock/31e/r2i00vytkwnj0h48fg0eaa1ksi769yvc/1720767003-51FCsYfdPL.jpg",
            category: Category(id: 1, name: "Wine", iconUrl: ""),
            qty: 14,
            unit: ItemUnit.bottle,
            minStock: 20,
          ),
        ),
        ProductCategoryCard(
          item: ProductListItem(
            id: "2231dfd",
            name: "Some wine",
            imageUrl:
                "https://winemore.ru/upload/iblock/31e/r2i00vytkwnj0h48fg0eaa1ksi769yvc/1720767003-51FCsYfdPL.jpg",
            category: Category(id: 1, name: "Wine", iconUrl: ""),
            qty: 14,
            unit: ItemUnit.bottle,
            minStock: 20,
          ),
        ),
      ],
    ).withPadding(horizontal: 16, vertical: 12);
  }
}
