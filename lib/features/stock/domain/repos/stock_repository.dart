import 'package:bar_stock/core/utils/result.dart';
import 'package:bar_stock/features/stock/domain/entities/category.dart';
import 'package:bar_stock/features/stock/domain/entities/product_item.dart';
import 'package:bar_stock/features/stock/domain/types/stock_typedef.dart';

abstract class StockRepository {
  Future<Result<AllProductListByCategory>> getProducts();
  Future<Result<ProductItem>> getById(int id);
  Future<Result<Category>> getCategoryById(int categoryId);
  Future<Result<ProductList>> getByCategory(int categoryId);
  Future<Result<ProductListByCategory>> getProductsForList();
}
