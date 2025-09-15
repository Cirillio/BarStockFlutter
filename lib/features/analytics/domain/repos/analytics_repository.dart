import 'package:bar_stock/core/utils/result.dart';
import 'package:bar_stock/features/analytics/domain/entities/category_info.dart';
import 'package:bar_stock/features/analytics/domain/entities/category_stock.dart';
import 'package:bar_stock/features/analytics/domain/entities/inventory_overview.dart';
import 'package:bar_stock/features/analytics/domain/entities/product_stock.dart';

typedef CategoryStockList = List<CategoryStock>;
typedef ProductStockList = List<ProductStock>;
typedef CategoryInfoList = List<CategoryInfo>;

abstract class AnalyticsRepository {
  Future<Result<CategoryStockList>> getCategoryStockOverview();
  Future<Result<ProductStockList>> getProductStockByCategory(int categoryId);
  Future<Result<CategoryInfoList>> getAvailableCategories();
  Future<Result<InventoryOverview>> getInventoryOverview();
}
