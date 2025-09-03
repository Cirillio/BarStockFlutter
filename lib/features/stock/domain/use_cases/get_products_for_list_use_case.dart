import 'package:bar_stock/core/utils/result.dart';
import 'package:bar_stock/features/stock/domain/entities/category.dart';
import 'package:bar_stock/features/stock/domain/entities/product_list_item.dart';
import 'package:bar_stock/features/stock/domain/repos/stock_repository.dart';

class GetProductsForListUseCase {
  final StockRepository repository;

  GetProductsForListUseCase({required this.repository});

  Future<Result<Map<Category, List<ProductListItem>>>> call() async {
    try {
      final result = await repository.getProductsForList();
      return result;
    } catch (e) {
      return Failure("Failed to get products for list: $e");
    }
  }
}
