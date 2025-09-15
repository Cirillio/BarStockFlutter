/// Представляет агрегированную информацию об остатках в категории
/// Используется для построения BarChart с общей картиной склада
class CategoryStock {
  const CategoryStock({
    required this.categoryId,
    required this.categoryName,
    required this.totalStock,
    required this.productsCount,
    this.iconUrl,
  });

  /// Уникальный идентификатор категории
  final int categoryId;

  /// Отображаемое название категории ("Вино", "Виски", и т.д.)
  final String categoryName;

  /// Общее количество единиц товара в категории
  /// Это сумма всех остатков товаров, принадлежащих категории
  /// Например: 6 бутылок Каберне + 7 Шардоне = 13 единиц в категории "Вино"
  final double totalStock;

  /// Количество разных товаров в категории
  /// Показывает разнообразие ассортимента в категории
  final int productsCount;

  /// URL иконки категории для отображения в UI
  final String? iconUrl;

  @override
  String toString() => 'CategoryStock(name: $categoryName, stock: $totalStock)';
}
