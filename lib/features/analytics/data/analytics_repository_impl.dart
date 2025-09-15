import 'package:bar_stock/core/utils/result.dart';
import 'package:bar_stock/features/analytics/data/analytics_data_source.dart';
import 'package:bar_stock/features/analytics/domain/entities/category_info.dart';
import 'package:bar_stock/features/analytics/domain/entities/category_stock.dart';
import 'package:bar_stock/features/analytics/domain/entities/inventory_overview.dart';
import 'package:bar_stock/features/analytics/domain/entities/product_stock.dart';
import 'package:bar_stock/features/analytics/domain/repos/analytics_repository.dart';
import 'package:bar_stock/features/stock/domain/entities/item_unit.dart';

class AnalyticsRepositoryImpl implements AnalyticsRepository {
  const AnalyticsRepositoryImpl({required this.remoteDataSource});

  final AnalyticsRemoteDataSource remoteDataSource;

  @override
  Future<Result<CategoryStockList>> getCategoryStockOverview() async {
    try {
      final data = await remoteDataSource.getCategoryStockData();
      return Success(data.map(_mapToCategoryStock).toList());
    } on DataSourceException {
      rethrow;
    } catch (e) {
      return Failure(e.toString());
    }
  }

  @override
  Future<Result<ProductStockList>> getProductStockByCategory(
    int categoryId,
  ) async {
    try {
      final data = await remoteDataSource.getProductStockData(categoryId);
      return Success(data.map(_mapToProductStock).toList());
    } on DataSourceException {
      rethrow;
    } catch (e) {
      return Failure(e.toString());
    }
  }

  @override
  Future<Result<CategoryInfoList>> getAvailableCategories() async {
    try {
      final data = await remoteDataSource.getCategoriesData();
      return Success(data.map(_mapToCategoryInfo).toList());
    } on DataSourceException {
      rethrow;
    } catch (e) {
      return Failure(e.toString());
    }
  }

  @override
  Future<Result<InventoryOverview>> getInventoryOverview() async {
    try {
      final data = await remoteDataSource.getInventoryOverviewData();
      return Success(_mapToInventoryOverview(data));
    } on DataSourceException {
      rethrow;
    } catch (e) {
      return Failure(e.toString());
    }
  }

  // Маппинг из Map в Entity объекты

  CategoryStock _mapToCategoryStock(Map<String, dynamic> map) {
    return CategoryStock(
      categoryId: _parseInt(map['category_id']),
      categoryName: _parseString(map['category_name']),
      totalStock: _parseDouble(map['total_stock']),
      productsCount: _parseInt(map['products_count']),
      iconUrl: map['icon_url'] as String?,
    );
  }

  ProductStock _mapToProductStock(Map<String, dynamic> map) {
    return ProductStock(
      productId: _parseString(map['product_id']),
      productName: _parseString(map['product_name']),
      currentStock: _parseDouble(map['current_stock']),
      minStock: _parseDouble(map['min_stock']),
      unit: _parseUnit(map['unit']),
      imageUrl: map['image_url'] as String?,
    );
  }

  CategoryInfo _mapToCategoryInfo(Map<String, dynamic> map) {
    return CategoryInfo(
      id: _parseInt(map['id']),
      name: _parseString(map['name']),
      iconUrl: map['icon_url'] as String?,
    );
  }

  InventoryOverview _mapToInventoryOverview(Map<String, dynamic> map) {
    return InventoryOverview(
      totalProducts: _parseInt(map['total_products']),
      totalStock: _parseDouble(map['total_stock']),
      criticalProductsCount: _parseInt(map['critical_products_count']),
      totalInventoryValue: _parseDouble(map['total_inventory_value']),
      categoriesCount: _parseInt(map['categories_count']),
    );
  }

  // Безопасные парсеры для работы с данными из БД

  String _parseString(dynamic value) {
    if (value == null) throw const FormatException('String value is null');
    return value.toString();
  }

  int _parseInt(dynamic value) {
    if (value == null) throw const FormatException('Int value is null');
    if (value is int) return value;
    if (value is String) {
      final parsed = int.tryParse(value);
      if (parsed != null) return parsed;
    }
    throw FormatException('Cannot parse int from: $value');
  }

  double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      final parsed = double.tryParse(value);
      if (parsed != null) return parsed;
    }
    throw FormatException('Cannot parse double from: $value');
  }

  ItemUnit _parseUnit(dynamic value) {
    if (value == null) return ItemUnit.bottle;
    return ItemUnitExtension.fromString(value.toString());
  }
}

/// Исключение для ошибок Repository слоя
class RepositoryException implements Exception {
  const RepositoryException(this.message);

  final String message;

  @override
  String toString() => 'RepositoryException: $message';
}
