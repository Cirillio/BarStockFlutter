import 'package:bar_stock/core/constants/state_status.dart';
import 'package:bar_stock/core/shared_ui/widgets/fetch_error_reload.dart';
import 'package:bar_stock/di/stock/stock_provider.dart';
import 'package:bar_stock/features/stock/presentation/states/category_list_state.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:bar_stock/features/stock/presentation/pages/category/build_category.dart';
import 'package:bar_stock/features/stock/presentation/pages/category/build_products.dart';

class CategoryPage extends HookConsumerWidget {
  const CategoryPage({super.key, required this.categoryId});
  final int categoryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryCtrl = ref.read(categoryListControllerProvider.notifier);
    final categoryState = ref.watch(categoryListControllerProvider);

    loadProds() async => await categoryCtrl.loadItems(categoryId);
    loadCategory() async => await categoryCtrl.loadCategory(categoryId);

    useEffect(() {
      categoryCtrl.load(categoryId);
      return null;
    }, [categoryId]);

    if (categoryState.categoryStatus == StateStatus.failure ||
        categoryState.itemsStatus == StateStatus.failure) {
      return FetchErrorReload(
        onReload: () async => await categoryCtrl.load(categoryId),
        title: 'Ошибка загрузки категории.',
        errors: categoryState.errors,
      );
    }

    return _buildPage(context, categoryState, loadCategory, loadProds);
  }
}

Widget _buildPage(
  BuildContext context,
  CategoryListState state,
  Future<void> Function() loadCategory,
  Future<void> Function() loadProducts,
) {
  return Column(
    children: [
      BuildCategory(context: context, state: state, load: loadCategory),
      BuildProducts(context: context, state: state, load: loadProducts),
    ],
  );
}
