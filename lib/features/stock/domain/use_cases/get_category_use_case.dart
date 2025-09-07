import 'package:bar_stock/core/utils/result.dart';
import 'package:bar_stock/features/stock/domain/entities/category.dart';
import 'package:bar_stock/features/stock/domain/repos/stock_repository.dart';

class GetCategoryUseCase {
  final StockRepository repository;

  GetCategoryUseCase({required this.repository});

  Future<Result<Category>> call(int categoryId) async {
    try {
      final result = await repository.getCategoryById(categoryId);
      return result;
    } catch (e) {
      return Failure('Failed to get category: $e');
    }
  }
}
