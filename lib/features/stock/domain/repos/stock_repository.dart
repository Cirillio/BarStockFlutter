import 'package:bar_stock/core/utils/result.dart';
import 'package:bar_stock/features/stock/domain/entities/product_item.dart';
import 'package:bar_stock/features/stock/domain/types/stock_list.dart';

typedef CategoryList = List<ProductItem>;

abstract class StockRepository {
  Future<Result<StockList>> getProducts();
  Future<Result<ProductItem>> getById(int id);
  Future<Result<CategoryList>> getByCategory(int categoryId);
}
