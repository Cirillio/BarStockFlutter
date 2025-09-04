import 'package:bar_stock/core/constants/state_status.dart';
import 'package:bar_stock/core/utils/result.dart';
import 'package:bar_stock/features/stock/domain/use_cases/get_products_for_list_use_case.dart';
import 'package:bar_stock/features/stock/presentation/states/stock_list_state.dart';
import 'package:bar_stock/core/utils/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StockListController extends StateNotifier<StockListState> {
  final GetProductsForListUseCase getProductsForListUseCase;

  StockListController({required this.getProductsForListUseCase})
    : super(const StockListState());

  Future<void> loadProductsForList() async {
    log.i("StockListController | Loading products for list");
    state = state.copyWith(status: StateStatus.submitting);

    final result = await getProductsForListUseCase.call();

    switch (result) {
      case Success():
        state = state.copyWith(
          status: StateStatus.success,
          stockList: result.data,
        );
        log.i("StockListController | Loaded ${result.data.length} categories");
      case Failure(:final message):
        state = state.copyWith(
          status: StateStatus.failure,
          errors: {"fetch_error": message},
        );
        log.e("StockListController | Error: $message");
        break;
    }
  }
}
