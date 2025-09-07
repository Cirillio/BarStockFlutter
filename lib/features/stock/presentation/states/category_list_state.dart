import 'package:bar_stock/core/constants/state_status.dart';
import 'package:bar_stock/features/stock/domain/entities/category.dart';
import 'package:bar_stock/features/stock/domain/types/stock_typedef.dart';
import 'package:bar_stock/features/stock/presentation/states/stock_state.dart';

class CategoryListState extends StockState {
  final Category? category;
  final ProductList items;

  final StateStatus categoryStatus;
  final StateStatus itemsStatus;

  const CategoryListState({
    required this.category,
    required this.items,
    this.categoryStatus = StateStatus.initial,
    this.itemsStatus = StateStatus.initial,
    super.errors,
  });

  bool get hasData => items.isNotEmpty;
  bool get hasCategory => category != null;

  CategoryListState copyWith({
    ProductList? items,
    Category? category,
    StateStatus? categoryStatus,
    StateStatus? itemsStatus,
    Map<String, String>? errors,
  }) {
    return CategoryListState(
      category: category ?? this.category,
      items: items ?? this.items,
      categoryStatus: categoryStatus ?? this.categoryStatus,
      itemsStatus: itemsStatus ?? this.itemsStatus,
      errors: errors ?? this.errors,
    );
  }
}
