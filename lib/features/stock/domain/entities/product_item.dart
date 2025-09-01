import 'package:bar_stock/features/stock/domain/entities/item_unit.dart';

class ProductItem {
  final int id;
  final int categoryId;
  final String name;
  final String imageUrl;
  final int qty;
  final ItemUnit unit;
  final double minStock;

  const ProductItem({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.imageUrl,
    required this.qty,
    required this.unit,
    required this.minStock,
  });
}
