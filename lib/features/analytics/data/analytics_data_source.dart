import 'package:bar_stock/core/utils/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Абстракция для получения аналитических данных
abstract class AnalyticsRemoteDataSource {
  AnalyticsRemoteDataSource(SupabaseClient read);

  Future<List<Map<String, dynamic>>> getCategoryStockData();
  Future<List<Map<String, dynamic>>> getProductStockData(int categoryId);
  Future<List<Map<String, dynamic>>> getCategoriesData();
  Future<Map<String, dynamic>> getInventoryOverviewData();
}

/// Реализация DataSource для работы с Supabase
class AnalyticsRemoteDataSourceImpl implements AnalyticsRemoteDataSource {
  const AnalyticsRemoteDataSourceImpl({required this.supabaseClient});

  final SupabaseClient supabaseClient;

  @override
  Future<List<Map<String, dynamic>>> getCategoryStockData() async {
    try {
      log.i("AnalyticsDataSource | Getting category stock data");
      final response = await supabaseClient.rpc('get_category_stock_overview');
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      log.e("AnalyticsDataSource Error | getCategoryStockData | $e");
      throw DataSourceException('Failed to fetch category stock data: $e');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getProductStockData(int categoryId) async {
    try {
      log.i("AnalyticsDataSource | Getting Product Stock Data");
      final response = await supabaseClient.rpc(
        'get_product_stock_by_category',
        params: {'category_id_param': categoryId},
      );
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      log.e("AnalyticsDataSource Error | getProductStockData | $e");
      throw DataSourceException('Failed to fetch product stock data: $e');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getCategoriesData() async {
    try {
      log.i("AnalyticsDataSource | Getting Categories Data");
      final response = await supabaseClient
          .from('categories')
          .select('id, name, icon_url')
          .order('name');
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      log.e("AnalyticsDataSource Error | getCategoriesData | $e");
      throw DataSourceException('Failed to fetch categories data: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> getInventoryOverviewData() async {
    try {
      log.i("AnalyticsDataSource | Getting Inventory Overview Data");
      final response = await supabaseClient.rpc('get_inventory_overview');
      return Map<String, dynamic>.from(response.first);
    } catch (e) {
      log.e("AnalyticsDataSource Error | getInventoryOverviewData | $e");
      throw DataSourceException('Failed to fetch inventory overview: $e');
    }
  }
}

/// Исключение для ошибок DataSource слоя
class DataSourceException implements Exception {
  const DataSourceException(this.message);

  final String message;

  @override
  String toString() => 'DataSourceException: $message';
}
