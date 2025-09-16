import 'package:bar_stock/di/supabase.dart';
import 'package:bar_stock/features/stock/data/stock_data_source.dart';
import 'package:bar_stock/features/stock/data/stock_repository_impl.dart';
import 'package:bar_stock/features/stock/domain/repos/stock_repository.dart';
import 'package:bar_stock/features/stock/domain/use_cases/get_category_use_case.dart';
import 'package:bar_stock/features/stock/domain/use_cases/get_products_by_category_use_case.dart';
import 'package:bar_stock/features/stock/domain/use_cases/get_products_for_list_use_case.dart';
import 'package:bar_stock/features/stock/presentation/controllers/category_list_controller.dart';
import 'package:bar_stock/features/stock/presentation/controllers/stock_list_controller.dart';
import 'package:bar_stock/features/stock/presentation/states/category_list_state.dart';
import 'package:bar_stock/features/stock/presentation/states/stock_list_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final stockDataSourceProvider = Provider<StockDataSource>(
  (ref) => StockDataSource(ref.read(supabaseClientProvider)),
);

final stockRepositoryProvider = Provider<StockRepository>(
  (ref) => StockRepositoryImpl(ref.read(stockDataSourceProvider)),
);

final getProductsForListUseCaseProvider = Provider<GetProductsForListUseCase>(
  (ref) =>
      GetProductsForListUseCase(repository: ref.read(stockRepositoryProvider)),
);

final getProductsByCategoryProvider = Provider<GetProductsByCategoryUseCase>(
  (ref) => GetProductsByCategoryUseCase(
    repository: ref.read(stockRepositoryProvider),
  ),
);

final getCategoryProvider = Provider<GetCategoryUseCase>(
  (ref) => GetCategoryUseCase(repository: ref.read(stockRepositoryProvider)),
);

final stockListControllerProvider =
    StateNotifierProvider<StockListController, StockListState>(
      (ref) => StockListController(
        getProductsForListUseCase: ref.read(getProductsForListUseCaseProvider),
      ),
    );

final categoryListControllerProvider =
    StateNotifierProvider<CategoryListController, CategoryListState>(
      (ref) => CategoryListController(
        getProductsByCategoryUseCase: ref.read(getProductsByCategoryProvider),
        getCategoryUseCase: ref.read(getCategoryProvider),
      ),
    );
