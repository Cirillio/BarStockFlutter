import 'package:bar_stock/core/utils/result.dart';
import 'package:bar_stock/features/stock/domain/entities/category.dart';
import 'package:bar_stock/features/stock/domain/entities/product_item.dart';
import 'package:bar_stock/features/stock/domain/repos/stock_repository.dart';

typedef StockList = Map<Category, List<ProductItem>>;

class GetAllUseCase {
  final StockRepository stockRepo;
  const GetAllUseCase(this.stockRepo);

  Future<Result<StockList>> call() {
    return stockRepo.getProducts();
  }
}
