/// Общая сводка по всему инвентарю бара
/// Используется для отображения ключевых метрик на главной странице аналитики
class InventoryOverview {
  const InventoryOverview({
    required this.totalProducts,
    required this.totalStock,
    required this.criticalProductsCount,
    required this.totalInventoryValue,
    required this.categoriesCount,
  });

  /// Общее количество разных товаров в базе
  final int totalProducts;

  /// Общее количество единиц товара на складе
  /// Сумма всех остатков по всем товарам
  final double totalStock;

  /// Количество товаров с критическими остатками
  /// Товары, которые нужно срочно заказывать
  final int criticalProductsCount;

  /// Общая стоимость инвентаря (по себестоимости)
  /// currentStock * costPrice для всех товаров
  final double totalInventoryValue;

  /// Количество категорий, в которых есть товары
  final int categoriesCount;

  /// Процент товаров с критическими остатками
  double get criticalPercentage =>
      totalProducts > 0 ? (criticalProductsCount / totalProducts) * 100 : 0.0;

  /// Средняя стоимость единицы товара
  double get averageItemValue =>
      totalStock > 0 ? totalInventoryValue / totalStock : 0.0;

  @override
  String toString() =>
      'InventoryOverview(products: $totalProducts, value: \$${totalInventoryValue.toStringAsFixed(2)})';
}
