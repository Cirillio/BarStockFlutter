import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:bar_stock/features/stock/presentation/widgets/category_section.dart';
import 'package:bar_stock/features/stock/domain/entities/product_item.dart';
import 'package:bar_stock/features/stock/domain/entities/item_unit.dart';

const List<ProductItem> drinks = [
  ProductItem(
    id: 1,
    categoryId: 1,
    name: "Wine 1",
    imageUrl:
        "https://avatars.mds.yandex.net/i?id=e4b50df035cf064b7e2dd1d82a152d16_l-5436735-images-thumbs&n=13",
    qty: 123,
    unit: ItemUnit.bottle,
    minStock: 10,
  ),
  ProductItem(
    id: 2,
    categoryId: 1,
    name: "Wine 2",
    imageUrl:
        "https://avatars.mds.yandex.net/i?id=e4b50df035cf064b7e2dd1d82a152d16_l-5436735-images-thumbs&n=13",
    qty: 123,
    unit: ItemUnit.bottle,
    minStock: 10,
  ),
];

class DrinkList extends ConsumerWidget {
  const DrinkList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      itemCount: 6,
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemBuilder: (context, index) =>
          CategorySection(categoryTitle: "Wines", drinks: drinks),
    );
  }
}
