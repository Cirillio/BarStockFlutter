import 'package:bar_stock/features/stock/domain/entities/product_item.dart';

class ProductItemDetailes extends ProductItem {
  final double costPrice;
  final double salePrice;

  ProductItemDetailes({
    required super.id,
    required super.categoryId,
    required super.name,
    required super.imageUrl,
    required super.qty,
    required super.unit,
    required super.minStock,
    required this.costPrice,
    required this.salePrice,
  });
}
