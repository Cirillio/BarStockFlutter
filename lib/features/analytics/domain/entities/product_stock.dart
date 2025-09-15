import 'package:bar_stock/features/stock/domain/entities/item_unit.dart';

/// Представляет детальную информацию о конкретном товаре
/// Используется для построения PieChart и детальной таблицы товаров в категории
class ProductStock {
  const ProductStock({
    required this.productId,
    required this.productName,
    required this.currentStock,
    required this.minStock,
    required this.unit,
    this.imageUrl,
  });

  /// Уникальный идентификатор товара
  final String productId;

  /// Название товара ("Cabernet Sauvignon 0.75L")
  final String productName;

  /// Текущий остаток товара на складе
  final double currentStock;

  /// Минимально допустимый остаток
  /// Когда currentStock <= minStock, товар считается критичным
  final double minStock;

  /// Единица измерения ("bottle", "liter", и т.д.)
  final ItemUnit unit;

  /// URL изображения товара
  final String? imageUrl;

  /// Проверяет, является ли остаток критичным
  /// Критичный товар нужно срочно заказывать у поставщика
  bool get isCritical => currentStock <= minStock;

  /// Процентное соотношение текущего остатка к минимальному
  /// Помогает понять насколько критична ситуация
  double get stockLevel => minStock > 0 ? (currentStock / minStock) : 1.0;

  /// Отображаемый текст остатка с единицей измерения
  String get stockDisplay => '$currentStock $unit';

  @override
  String toString() =>
      'ProductStock(name: $productName, stock: $currentStock/$minStock)';
}
