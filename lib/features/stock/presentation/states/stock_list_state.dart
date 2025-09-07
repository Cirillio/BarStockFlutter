import 'package:bar_stock/core/constants/state_status.dart';
import 'package:bar_stock/features/stock/domain/entities/category.dart';
import 'package:bar_stock/features/stock/domain/entities/product_list_item.dart';
import 'package:bar_stock/features/stock/presentation/states/stock_state.dart';

class StockListState extends StockState {
  final Map<Category, List<ProductListItem>> stockList;
  final StateStatus status;

  const StockListState({
    this.status = StateStatus.initial,
    super.errors,
    this.stockList = const {},
  });

  bool get hasData => stockList.isNotEmpty;

  StockListState copyWith({
    StateStatus? status,
    Map<Category, List<ProductListItem>>? stockList,
    Map<String, String>? errors,
  }) {
    return StockListState(
      status: status ?? this.status,
      stockList: stockList ?? this.stockList,
      errors: errors ?? this.errors,
    );
  }
}
