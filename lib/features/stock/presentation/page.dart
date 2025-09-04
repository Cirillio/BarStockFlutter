import 'package:bar_stock/di/stock/stock_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:bar_stock/features/stock/presentation/widgets/categories_item_list.dart';

class StockPage extends ConsumerStatefulWidget {
  const StockPage({super.key});

  @override
  ConsumerState<StockPage> createState() => _StockPageState();
}

class _StockPageState extends ConsumerState<StockPage> {
  @override
  void initState() {
    super.initState();
    // Загружаем данные при инициализации страницы
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(stockListControllerProvider.notifier).loadProductsForList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final stockState = ref.watch(stockListControllerProvider);

    if (stockState.isLoading) {
      return const Center(child: CircularProgressIndicator(size: 24));
    }

    if (stockState.isFailure) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(LucideIcons.circleAlert, size: 48),
            const SizedBox(height: 16),
            Text('Ошибка загрузки данных'),
            const SizedBox(height: 8),
            if (stockState.hasErrors) Text(stockState.errors.values.first),
            const SizedBox(height: 16),
            Button.outline(
              onPressed: () => ref
                  .read(stockListControllerProvider.notifier)
                  .loadProductsForList(),
              child: const Text('Повторить'),
            ),
          ],
        ),
      );
    }

    return CategoriesItemList(categoriesItemList: stockState.stockList);
  }
}
