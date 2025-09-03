import 'package:bar_stock/core/constants/state_status.dart';
import 'package:bar_stock/features/stock/domain/entities/category.dart';
import 'package:bar_stock/features/stock/domain/entities/product_list_item.dart';

class StockListState {
  final StateStatus status;
  final Map<Category, List<ProductListItem>> stockList;
  final Map<String, String> errors;

  const StockListState({
    this.status = StateStatus.initial,
    this.stockList = const {},
    this.errors = const {},
  });

  bool get hasErrors => errors.isNotEmpty;
  bool get isLoading => status == StateStatus.submitting;
  bool get isSuccess => status == StateStatus.success;
  bool get isFailure => status == StateStatus.failure;
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