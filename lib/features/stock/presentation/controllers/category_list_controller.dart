import 'package:bar_stock/core/constants/state_status.dart';
import 'package:bar_stock/core/utils/result.dart';
import 'package:bar_stock/core/utils/logger.dart';
import 'package:bar_stock/features/stock/domain/use_cases/get_category_use_case.dart';
import 'package:bar_stock/features/stock/domain/use_cases/get_products_by_category_use_case.dart';
import 'package:bar_stock/features/stock/presentation/states/category_list_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryListController extends StateNotifier<CategoryListState> {
  final GetProductsByCategoryUseCase getProductsByCategoryUseCase;
  final GetCategoryUseCase getCategoryUseCase;

  CategoryListController({
    required this.getProductsByCategoryUseCase,
    required this.getCategoryUseCase,
  }) : super(CategoryListState(category: null, items: []));

  Future<void> loadCategory(int id) async {
    log.i('CategoryListController | Loading category...');
    state = state.copyWith(categoryStatus: StateStatus.submitting);

    final result = await getCategoryUseCase(id);

    switch (result) {
      case Success():
        state = state.copyWith(
          categoryStatus: StateStatus.success,
          category: result.data,
        );
      case Failure(:final message):
        state = state.copyWith(
          categoryStatus: StateStatus.failure,
          errors: {...state.errors, 'category_fetch_error': message},
        );
        log.e("CategoryListController | Error: $message");
        break;
    }
  }

  Future<void> loadProducts(int id) async {
    log.i('CategoryListController | Loading products by category...');
    state = state.copyWith(itemsStatus: StateStatus.submitting);

    final result = await getProductsByCategoryUseCase(id);

    switch (result) {
      case Success():
        state = state.copyWith(
          itemsStatus: StateStatus.success,
          items: result.data,
        );
      case Failure(:final message):
        state = state.copyWith(
          itemsStatus: StateStatus.failure,
          errors: {
            ...state.errors,
            'products_by_category_fetch_error': message,
          },
        );
        log.e("CategoryListController | Error: $message");
        break;
    }
  }

  Future<void> load(int categoryId) async {
    await Future.wait([loadCategory(categoryId), loadProducts(categoryId)]);
  }
}
