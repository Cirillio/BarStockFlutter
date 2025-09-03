import 'package:bar_stock/di/supabase.dart';
import 'package:bar_stock/features/stock/data/stock_data_source.dart';
import 'package:bar_stock/features/stock/data/stock_repository_impl.dart';
import 'package:bar_stock/features/stock/domain/repos/stock_repository.dart';
import 'package:bar_stock/features/stock/domain/use_cases/get_products_for_list_use_case.dart';
import 'package:bar_stock/features/stock/presentation/stock_list_controller.dart';
import 'package:bar_stock/features/stock/presentation/stock_list_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// ============================================================================
// DATA LAYER
// ============================================================================

final stockDataSourceProvider = Provider<StockDataSource>(
  (ref) => StockDataSource(ref.read(supabaseClientProvider)),
);

final stockRepositoryProvider = Provider<StockRepository>(
  (ref) => StockRepositoryImpl(ref.read(stockDataSourceProvider)),
);

// ============================================================================
// DOMAIN LAYER - USE CASES
// ============================================================================

final getProductsForListUseCaseProvider = Provider<GetProductsForListUseCase>(
  (ref) =>
      GetProductsForListUseCase(repository: ref.read(stockRepositoryProvider)),
);

// ============================================================================
// PRESENTATION LAYER - CONTROLLERS
// ============================================================================

/// Контроллер для получения облегченных данных товаров (для списков)
final stockListControllerProvider =
    StateNotifierProvider<StockListController, StockListState>(
      (ref) => StockListController(
        getProductsForListUseCase: ref.read(getProductsForListUseCaseProvider),
      ),
    );
