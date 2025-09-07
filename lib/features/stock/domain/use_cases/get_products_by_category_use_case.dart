import 'package:bar_stock/core/utils/result.dart';
import 'package:bar_stock/features/stock/domain/repos/stock_repository.dart';
import 'package:bar_stock/features/stock/domain/types/stock_typedef.dart';

class GetProductsByCategoryUseCase {
  final StockRepository repository;

  GetProductsByCategoryUseCase({required this.repository});

  Future<Result<ProductList>> call(int categoryId) async {
    try {
      final result = await repository.getByCategory(categoryId);
      return result;
    } catch (e) {
      return Failure('Failed to get products by category: $e');
    }
  }
}
