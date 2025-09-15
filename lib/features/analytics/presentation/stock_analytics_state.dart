import 'package:bar_stock/features/analytics/domain/entities/category_info.dart';
import 'package:bar_stock/features/analytics/domain/entities/category_stock.dart';
import 'package:bar_stock/features/analytics/domain/entities/product_stock_analytics.dart';

class StockAnalyticsState {
  const StockAnalyticsState({
    this.categoryStocks = const [],
    this.productAnalytics,
    this.categories = const [],
    this.selectedCategoryId,
    this.isLoading = false,
    this.errorMessage,
  });

  /// Данные для BarChart - остатки по всем категориям
  final List<CategoryStock> categoryStocks;

  /// Детальная аналитика по выбранной категории (для PieChart + таблица)
  final ProductStockAnalytics? productAnalytics;

  /// Список всех доступных категорий для dropdown
  final List<CategoryInfo> categories;

  /// ID выбранной категории (null = "По всем категориям")
  final int? selectedCategoryId;

  /// Индикатор загрузки
  final bool isLoading;

  /// Сообщение об ошибке
  final String? errorMessage;

  /// Показывать ли общий график (все категории)
  bool get showOverview => selectedCategoryId == null;

  /// Название выбранной категории
  String get selectedCategoryName {
    if (selectedCategoryId == null) return 'По всем категориям';
    return categories.firstWhere((c) => c.id == selectedCategoryId).name;
  }

  /// Есть ли ошибка
  bool get hasError => errorMessage != null;

  /// Есть ли данные для отображения
  bool get hasData =>
      showOverview ? categoryStocks.isNotEmpty : productAnalytics != null;

  StockAnalyticsState copyWith({
    List<CategoryStock>? categoryStocks,
    ProductStockAnalytics? productAnalytics,
    List<CategoryInfo>? categories,
    int? selectedCategoryId,
    bool? isLoading,
    String? errorMessage,
  }) {
    return StockAnalyticsState(
      categoryStocks: categoryStocks ?? this.categoryStocks,
      productAnalytics: productAnalytics ?? this.productAnalytics,
      categories: categories ?? this.categories,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  /// Очищает состояние ошибки
  StockAnalyticsState clearError() {
    return copyWith(errorMessage: null);
  }

  /// Сбрасывает выбор категории
  StockAnalyticsState resetToOverview() {
    return copyWith(
      selectedCategoryId: null,
      productAnalytics: null,
      errorMessage: null,
    );
  }
}
