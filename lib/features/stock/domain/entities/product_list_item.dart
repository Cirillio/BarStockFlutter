import 'package:bar_stock/features/stock/domain/entities/category.dart';
import 'package:bar_stock/features/stock/domain/entities/item_unit.dart';

class ProductListItem {
  final String id;
  final String name;
  final String imageUrl;
  final Category category;
  final double qty;
  final ItemUnit unit;
  final double minStock;

  const ProductListItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.category,
    required this.qty,
    required this.unit,
    required this.minStock,
  });

  factory ProductListItem.fromJson(Map<String, dynamic> json) {
    return ProductListItem(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['image_url'] as String? ?? '',
      category: Category.fromJson(json['categories'] as Map<String, dynamic>),
      qty: ((json['inventory'] as Map<String, dynamic>)['qty'] as num)
          .toDouble(),
      unit: ItemUnitExtension.fromString(json['unit'] as String),
      minStock: (json['min_stock'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image_url': imageUrl,
      'categories': category.toJson(),
      'inventory': {'qty': qty},
      'unit': unit.name,
      'min_stock': minStock,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductListItem && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'ProductListItem(id: $id, name: $name, imageUrl: $imageUrl, category: $category, qty: $qty, unit: $unit, minStock: $minStock)';
  }
}
