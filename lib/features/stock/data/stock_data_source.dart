import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bar_stock/core/utils/logger.dart';

typedef AllList = List<Map<String, dynamic>>;

class StockDataSource {
  final SupabaseClient client;

  StockDataSource(this.client);

  Future<AllList> getAll() async {
    const query =
        "id, name, image_url, unit, min_stock, categories(name), inventory(qty)";

    try {
      log.i("StockDataSource | Getting all products with query: $query");
      final response = await client.from('products').select(query);
      final list = AllList.from(response);

      if (list.isNotEmpty) {
        log.i("StockDataSource | Got ${list.length} products");
        log.i("StockDataSource | First product: ${list.first}");
      }

      return list;
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }
}
