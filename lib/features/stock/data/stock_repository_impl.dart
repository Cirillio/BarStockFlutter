import 'package:bar_stock/core/utils/result.dart';
import 'package:bar_stock/features/stock/data/stock_data_source.dart';
import 'package:bar_stock/features/stock/domain/entities/category.dart';
import 'package:bar_stock/features/stock/domain/entities/item_unit.dart';
import 'package:bar_stock/features/stock/domain/entities/product_item.dart';
import 'package:bar_stock/features/stock/domain/entities/product_list_item.dart';
import 'package:bar_stock/features/stock/domain/repos/stock_repository.dart';
import 'package:bar_stock/features/stock/domain/types/stock_typedef.dart';
import 'package:bar_stock/core/utils/logger.dart';

class StockRepositoryImpl implements StockRepository {
  final StockDataSource ds;
  StockRepositoryImpl(this.ds);

  @override
  Future<Result<Category>> getCategoryById(int categoryId) async {
    try {
      log.i("StockRepositoryImpl | Getting category by $categoryId");
      final res = await ds.getCategoryById(categoryId);

      log.i('StockRepositoryImpl | Got $res');

      return Success(Category.fromJson(res));
    } catch (e) {
      log.e('StockRepositoryImpl | Error: $e');
      return const Failure("Error getting category");
    }
  }

  @override
  Future<Result<AllProductListByCategory>> getProducts() async {
    try {
      log.i('StockRepositoryImpl | Getting all products');
      // final StockList finalProducts;
      final res = await ds.getAllProducts();

      log.i('StockRepositoryImpl | Got ${res.length} products');

      final List<ProductItem> prods = res
          .map((p) => convertToFullProduct(p))
          .toList();

      final AllProductListByCategory finalProducts = groupByCategory(prods);
      return Success(finalProducts);
    } catch (e) {
      log.e('StockRepositoryImpl | Error : $e');
      return const Failure('Error getting products');
    }
  }

  @override
  Future<Result<ProductItem>> getById(int id) async {
    return const Failure('not implemented');
  }

  @override
  Future<Result<ProductList>> getByCategory(int categoryId) async {
    try {
      log.i('StockRepoistoryImpl | Getting products for category $categoryId');

      final res = await ds.getProductsByCategory(categoryId);

      final ProductList finalProducts = res
          .map((p) => ProductListItem.fromJson(p))
          .toList();

      return Success(finalProducts);
    } catch (e) {
      log.e("Failed to fetch products by category $categoryId: $e");
      return const Failure("Error getting products by category in repository");
    }
  }

  @override
  Future<Result<ProductListByCategory>> getProductsForList() async {
    try {
      log.i('StockRepositoryImpl | Getting products for list view');

      final res = await ds.getProductsForList();
      log.i('StockRepositoryImpl | Got ${res.length} products for list');

      final List<ProductListItem> prods = res
          .map((p) => ProductListItem.fromJson(p))
          .toList();

      final ProductListByCategory finalProducts = groupListItemsByCategory(
        prods,
      );
      return Success(finalProducts);
    } catch (e) {
      log.e('StockRepositoryImpl | Error getting products for list: $e');
      return const Failure('Error getting products for list');
    }
  }

  ProductItem convertToFullProduct(Map<String, dynamic> rawProd) {
    final product = ProductItem(
      id: rawProd['id'] as String,
      name: rawProd['name'] as String,
      category: Category.fromJson(
        rawProd['categories'] as Map<String, dynamic>,
      ),
      imageUrl: rawProd['image_url'] as String? ?? '',
      qty: ((rawProd['inventory'] as Map<String, dynamic>)['qty'] as num)
          .toDouble(),
      unit: ItemUnitExtension.fromString(rawProd['unit'] as String),
      salePrice: (rawProd['sale_price'] as num).toDouble(),
      costPrice: (rawProd['cost_price'] as num).toDouble(),
      minStock: (rawProd['min_stock'] as num).toDouble(),
    );
    return product;
  }

  AllProductListByCategory groupByCategory(List<ProductItem> products) {
    final AllProductListByCategory stockList = {};
    final Map<int, Category> categoryById = {};

    for (final product in products) {
      final category = product.category;

      // Используем существующую категорию или добавляем новую
      final existingCategory = categoryById.putIfAbsent(
        category.id,
        () => category,
      );

      if (stockList.containsKey(existingCategory)) {
        stockList[existingCategory]!.add(product);
      } else {
        stockList[existingCategory] = [product];
      }
    }

    return stockList;
  }

  ProductListByCategory groupListItemsByCategory(
    List<ProductListItem> products,
  ) {
    final ProductListByCategory stockList = {};
    final Map<int, Category> categoryById = {};

    for (final product in products) {
      final category = product.category;

      // Используем существующую категорию или добавляем новую
      final existingCategory = categoryById.putIfAbsent(
        category.id,
        () => category,
      );

      if (stockList.containsKey(existingCategory)) {
        stockList[existingCategory]!.add(product);
      } else {
        stockList[existingCategory] = [product];
      }
    }

    return stockList;
  }
}
