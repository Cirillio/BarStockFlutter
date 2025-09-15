import 'package:bar_stock/features/analytics/domain/entities/product_stock.dart';
import 'package:bar_stock/features/analytics/domain/entities/stock_status.dart';

class ProductStockAnalytics {
  final List<ProductStock> products; // Все товары категории
  final double totalStock; // Общий остаток (55 бутылок)
  final List<ProductStock> criticalProducts; // Критичные товары
  final List<ProductStock> outOfStockProducts; // Закончившиеся

  ProductStockAnalytics({
    required this.products,
    required this.totalStock,
    required this.criticalProducts,
    required this.outOfStockProducts,
  });

  // Плюс удобные геттеры:
  int get healthyProductsCount => products
      .where(
        (p) =>
            StockStatus.fromStock(p.currentStock, p.minStock) ==
            StockStatus.normal,
      )
      .length; // Товары в норме
  double get criticalPercentage => products.isNotEmpty
      ? (criticalProducts.length / products.length) * 100
      : 0.0; // % критичных товаров
}
