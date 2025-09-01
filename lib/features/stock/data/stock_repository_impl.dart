import 'package:bar_stock/core/utils/result.dart';
import 'package:bar_stock/features/stock/data/stock_data_source.dart';
import 'package:bar_stock/features/stock/domain/entities/product_item.dart';
import 'package:bar_stock/features/stock/domain/repos/stock_repository.dart';
import 'package:bar_stock/features/stock/domain/types/stock_list.dart';

class StockRepositoryImpl implements StockRepository {
  final StockDataSource ds;
  StockRepositoryImpl(this.ds);

  @override
  Future<Result<StockList>> getProducts() async {
    return const Failure('not implemented');
  }

  @override
  Future<Result<ProductItem>> getById(int id) async {
    return const Failure('not implemented');
  }

  @override
  Future<Result<CategoryList>> getByCategory(int categoryId) async {
    return const Failure('not implemented');
  }
}
