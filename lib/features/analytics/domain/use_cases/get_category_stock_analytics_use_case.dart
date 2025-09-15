import 'package:bar_stock/core/utils/logger.dart';
import 'package:bar_stock/core/utils/result.dart';
import 'package:bar_stock/features/analytics/domain/entities/category_stock.dart';
import 'package:bar_stock/features/analytics/domain/repos/analytics_repository.dart';

class GetCategoryStockAnalyticsUseCase {
  const GetCategoryStockAnalyticsUseCase({required this.repository});

  final AnalyticsRepository repository;

  /// Возвращает список категорий с остатками, отсортированный по убыванию остатков
  /// Исключает пустые категории (где нет товаров)
  Future<List<CategoryStock>> call() async {
    final result = await repository.getCategoryStockOverview();

    if (result.isSuccess) {
      final data = result as Success<List<CategoryStock>>;
      final nonEmptyCategories = data.data
          .where((category) => category.totalStock > 0)
          .toList();
      nonEmptyCategories.sort((a, b) => b.totalStock.compareTo(a.totalStock));
      log.i(nonEmptyCategories);
      return nonEmptyCategories;
    }
    return [];
  }
}
