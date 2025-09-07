import 'package:bar_stock/features/stock/domain/entities/category.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bar_stock/core/utils/logger.dart';

typedef ProductsResponse = List<Map<String, dynamic>>;

class StockDataSource {
  final SupabaseClient _client;

  StockDataSource(this._client);

  // Оптимизированные запросы для разных контекстов

  // Для списка товаров на главной (только необходимые поля)
  static const String listItemsQuery = '''
    id, 
    name, 
    image_url, 
    unit, 
    min_stock, 
    categories(id, name, icon_url), 
    inventory(qty)
  ''';

  // Для детальной информации о товаре
  static const String productDetailsQuery = '''
    id, 
    name, 
    image_url, 
    unit, 
    min_stock, 
    sale_price,
    cost_price,
    created_at,
    updated_at,
    categories(id, name, icon_url), 
    inventory(qty, updated_at)
  ''';

  // Для отчетов и аналитики (без изображений для экономии трафика)
  static const String reportItemsQuery = '''
    id, 
    name, 
    cost_price,
    sale_price,
    categories(id, name), 
    inventory(qty)
  ''';

  // Для корзины/продаж
  static const String cartItemsQuery = '''
    id, 
    name, 
    image_url, 
    sale_price,
    unit
  ''';

  // Специализированные методы для разных контекстов

  Future<Map<String, dynamic>> getCategoryById(int categoryId) async {
    try {
      log.i("StockDataSource | Fetching category by id: $categoryId");

      final res = await _client
          .from('categories')
          .select()
          .eq('id', categoryId)
          .single();

      return res;
    } on PostgrestException catch (e) {
      log.e("StockDataSource | Database error: ${e.message}");
      throw StockDataSourceException(
        "Failed to fetch category by id($categoryId): ${e.message}",
      );
    } catch (e) {
      log.e("StockDataSource | Unexpected error: $e");
      throw StockDataSourceException("Unexpected error occurred");
    }
  }

  Future<ProductsResponse> getProductsForList() async {
    try {
      log.i("StockDataSource | Fetching products for list view");

      final categoriesResponse = await _client
          .from('categories')
          .select('id, name, icon_url')
          .order('name');

      final ProductsResponse stockList = [];

      for (final c in categoriesResponse) {
        final prod = await _client
            .from('products')
            .select(listItemsQuery)
            .eq('category_id', c['id'])
            .order('inventory(qty)')
            .limit(3);
        stockList.addAll(prod);
      }

      return stockList;
    } on PostgrestException catch (e) {
      log.e("StockDataSource | Database error: ${e.message}");
      throw StockDataSourceException(
        "Failed to fetch products for list: ${e.message}",
      );
    } catch (e) {
      log.e("StockDataSource | Unexpected error: $e");
      throw StockDataSourceException("Unexpected error occurred");
    }
  }

  Future<Map<String, dynamic>> getProductDetails(String productId) async {
    try {
      log.i("StockDataSource | Fetching product details: $productId");

      final response = await _client
          .from('products')
          .select(productDetailsQuery)
          .eq('id', productId)
          .single();

      return response;
    } on PostgrestException catch (e) {
      log.e("StockDataSource | Database error: ${e.message}");
      throw StockDataSourceException(
        "Failed to fetch product details: ${e.message}",
      );
    } catch (e) {
      log.e("StockDataSource | Unexpected error: $e");
      throw StockDataSourceException("Unexpected error occurred");
    }
  }

  Future<ProductsResponse> getCartItems(List<String> productIds) async {
    try {
      log.i(
        "StockDataSource | Fetching cart items: ${productIds.length} items",
      );

      final response = await _client
          .from('products')
          .select(cartItemsQuery)
          .inFilter('id', productIds);

      return ProductsResponse.from(response);
    } on PostgrestException catch (e) {
      log.e("StockDataSource | Database error: ${e.message}");
      throw StockDataSourceException(
        "Failed to fetch cart items: ${e.message}",
      );
    } catch (e) {
      log.e("StockDataSource | Unexpected error: $e");
      throw StockDataSourceException("Unexpected error occurred");
    }
  }

  Future<ProductsResponse> getAllProducts() async {
    try {
      log.i("StockDataSource | Fetching all products");

      final response = await _client
          .from('products')
          .select(productDetailsQuery)
          .order('name');

      final products = ProductsResponse.from(response);

      log.i("StockDataSource | Fetched ${products.length} products");

      if (products.isNotEmpty) {
        log.d("StockDataSource | Sample product: ${products.first}");
      }

      return products;
    } on PostgrestException catch (e) {
      log.e("StockDataSource | Database error: ${e.message}");
      throw StockDataSourceException("Failed to fetch products: ${e.message}");
    } catch (e) {
      log.e("StockDataSource | Unexpected error: $e");
      throw StockDataSourceException("Unexpected error occurred");
    }
  }

  Future<ProductsResponse> getProductsByCategory(int categoryId) async {
    try {
      log.i("StockDataSource | Fetching products for category: $categoryId");

      final response = await _client
          .from('products')
          .select(listItemsQuery)
          .eq('category_id', categoryId)
          .order('name');

      return ProductsResponse.from(response);
    } on PostgrestException catch (e) {
      log.e("StockDataSource | Database error: ${e.message}");
      throw StockDataSourceException(
        "Failed to fetch category products: ${e.message}",
      );
    } catch (e) {
      log.e("StockDataSource | Unexpected error: $e");
      throw StockDataSourceException("Unexpected error occurred");
    }
  }

  Future<ProductsResponse> searchProducts(String query) async {
    try {
      log.i("StockDataSource | Searching products: $query");

      final response = await _client
          .from('products')
          .select(listItemsQuery)
          .textSearch('name', query)
          .order('name');

      return ProductsResponse.from(response);
    } on PostgrestException catch (e) {
      log.e("StockDataSource | Search error: ${e.message}");
      throw StockDataSourceException("Search failed: ${e.message}");
    } catch (e) {
      log.e("StockDataSource | Unexpected error: $e");
      throw StockDataSourceException("Unexpected error occurred");
    }
  }

  Future<ProductsResponse> getLowStockProducts() async {
    try {
      log.i("StockDataSource | Fetching low stock products");

      // Используем RPC функцию или фильтр через inventory
      final response = await _client
          .from('products')
          .select(listItemsQuery)
          .filter('inventory.qty', 'lt', 'min_stock')
          .order('inventory(qty)');

      return ProductsResponse.from(response);
    } on PostgrestException catch (e) {
      log.e("StockDataSource | Low stock fetch error: ${e.message}");
      throw StockDataSourceException("Failed to fetch low stock: ${e.message}");
    } catch (e) {
      log.e("StockDataSource | Unexpected error: $e");
      throw StockDataSourceException("Unexpected error occurred");
    }
  }

  Future<void> updateStock(String productId, int newQuantity) async {
    try {
      log.i(
        "StockDataSource | Updating stock for product $productId to $newQuantity",
      );

      await _client
          .from('inventory')
          .update({
            'qty': newQuantity,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('product_id', productId);

      log.i("StockDataSource | Stock updated successfully");
    } on PostgrestException catch (e) {
      log.e("StockDataSource | Stock update error: ${e.message}");
      throw StockDataSourceException("Failed to update stock: ${e.message}");
    } catch (e) {
      log.e("StockDataSource | Unexpected error: $e");
      throw StockDataSourceException("Unexpected error occurred");
    }
  }

  RealtimeChannel subscribeToStockChanges({
    required void Function(Map<String, dynamic>) onStockUpdate,
  }) {
    log.i("StockDataSource | Subscribing to stock changes");

    return _client
        .channel('stock_changes')
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'inventory',
          callback: (payload) {
            log.d(
              "StockDataSource | Stock change detected: ${payload.newRecord}",
            );
            onStockUpdate(payload.newRecord);
          },
        )
        .subscribe();
  }
}

class StockDataSourceException implements Exception {
  final String message;
  StockDataSourceException(this.message);

  @override
  String toString() => 'StockDataSourceException: $message';
}
