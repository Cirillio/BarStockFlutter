import 'package:bar_stock/core/utils/result.dart';
import 'package:bar_stock/features/analytics/domain/entities/category_stock.dart';
import 'package:bar_stock/features/analytics/domain/use_cases/get_category_stock_analytics_use_case.dart';
import 'package:bar_stock/features/analytics/presentation/stock_analytics_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StockAnalyticsController extends StateNotifier<StockAnalyticsState> {
  StockAnalyticsController({
    required this.getCategoryStockUseCase,
    // required this.getProductStockUseCase,
    // required this.getCategoriesUseCase,
  }) : super(const StockAnalyticsState());

  final GetCategoryStockAnalyticsUseCase getCategoryStockUseCase;
  // final GetProductStockAnalyticsUseCase getProductStockUseCase;
  // final GetAvailableCategoriesUseCase getCategoriesUseCase;

  /// Инициализация - загружает категории и обзор остатков
  Future<void> initialize() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      // final categoriesResult = futures[0] as Result<List<CategoryInfo>>;
      final List<CategoryStock> stocksResult = await getCategoryStockUseCase();

      // if (categoriesResult.isFailure) {
      //   final failure = categoriesResult as Failure;
      //   state = state.copyWith(
      //     isLoading: false,
      //     errorMessage: 'Ошибка загрузки категорий: ${failure.message}',
      //   );
      //   return;
      // }

      if (stocksResult.isEmpty) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Ошибка загрузки остатков:',
        );
        return;
      }

      // final categories = (categoriesResult as Success<List<CategoryInfo>>).data;

      state = state.copyWith(
        // categories: categories,
        categories: [],
        categoryStocks: stocksResult,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Неожиданная ошибка: $e',
      );
    }
  }

  /// Выбирает категорию для детального просмотра
  // Future<void> selectCategory(int categoryId) async {
  //   if (state.selectedCategoryId == categoryId) return;

  //   state = state.copyWith(
  //     selectedCategoryId: categoryId,
  //     isLoading: true,
  //     errorMessage: null,
  //     productAnalytics: null,
  //   );

  //   final result = await getProductStockUseCase(categoryId);

  //   if (result.isFailure) {
  //     final failure = result as Failure;
  //     state = state.copyWith(
  //       isLoading: false,
  //       errorMessage: 'Ошибка загрузки товаров: ${failure.message}',
  //     );
  //     return;
  //   }

  //   final analytics = (result as Success<ProductStockAnalytics>).data;

  //   state = state.copyWith(productAnalytics: analytics, isLoading: false);
  // }

  /// Возвращается к обзору всех категорий
  void showOverview() {
    state = state.resetToOverview();
  }

  /// Обновляет данные (pull-to-refresh)
  Future<void> refresh() async {
    if (state.showOverview) {
      await _refreshOverview();
    } else {
      // await _refreshCategoryData();
    }
  }

  /// Очищает ошибку
  void clearError() {
    state = state.clearError();
  }

  // Приватные методы

  Future<void> _refreshOverview() async {
    final result = await getCategoryStockUseCase();

    if (result.isEmpty) {
      final failure = result as Failure;
      state = state.copyWith(errorMessage: failure.message);
      return;
    }

    final stocks = (result as Success<List<CategoryStock>>).data;
    state = state.copyWith(categoryStocks: stocks);
  }

  // Future<void> _refreshCategoryData() async {
  //   final categoryId = state.selectedCategoryId;
  //   if (categoryId == null) return;

  //   state = state.copyWith(isLoading: true);

  //   final result = await getProductStockUseCase(categoryId);

  //   if (result.isFailure) {
  //     final failure = result as Failure;
  //     state = state.copyWith(isLoading: false, errorMessage: failure.message);
  //     return;
  //   }

  //   final analytics = (result as Success<ProductStockAnalytics>).data;
  //   state = state.copyWith(productAnalytics: analytics, isLoading: false);
  // }
}
