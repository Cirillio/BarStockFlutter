import 'package:bar_stock/features/stock/domain/entities/item_unit.dart';
import 'package:bar_stock/features/stock/domain/entities/category.dart';

class ProductItem {
  final String id;
  final Category category;
  final String name;
  final String imageUrl;
  final double qty;
  final ItemUnit unit;
  final double salePrice;
  final double costPrice;
  final double minStock;

  const ProductItem({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.qty,
    required this.unit,
    required this.salePrice,
    required this.costPrice,
    required this.minStock,
  });

  @override
  String toString() {
    return 'ProductItem(\nid: $id, \nname: $name, \ncategory: ${category.toString()}, \nimageUrl: $imageUrl, \nqty: $qty, \nunit: $unit, \nminStock: $minStock)';
  }
}
