import 'package:bar_stock/core/constants/state_status.dart';
import 'package:bar_stock/di/stock/stock_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:bar_stock/features/stock/presentation/widgets/categories_item_list.dart';
import 'package:bar_stock/features/stock/presentation/widgets/skeletons/main_page_skeletons.dart';
import 'package:shadcn_flutter/shadcn_flutter_extension.dart';

class StockPage extends ConsumerStatefulWidget {
  const StockPage({super.key});

  @override
  ConsumerState<StockPage> createState() => _StockPageState();
}

class _StockPageState extends ConsumerState<StockPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(stockListControllerProvider.notifier).loadProductsForList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final stockState = ref.watch(stockListControllerProvider);

    if (stockState.status == StateStatus.submitting) {
      return buildSkeletonCategoryList(context);
    }

    if (stockState.status == StateStatus.failure) {
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

Widget buildSkeletonCategoryList(BuildContext context) {
  return Column(
    spacing: 8,
    children: [
      OutlineBadge(child: Text('Category title...')).asSkeleton(),
      SizedBox(
        height: 240,
        child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          separatorBuilder: (_, __) => const SizedBox(width: 16),
          itemCount: 3,
          itemBuilder: (context, _) => buildSkeletonCard(context),
        ),
      ),
    ],
  );
}

Widget buildSkeletonCard(BuildContext context) {
  return SizedBox(
    width: 160,

    child: Card(
      padding: EdgeInsets.all(12),
      child: Column(
        spacing: 6,
        children: [
          AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              decoration: BoxDecoration(
                color: context.theme.colorScheme.accent,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: context.theme.colorScheme.accent,
              borderRadius: BorderRadius.circular(8),
            ),
            height: 12,
            width: double.infinity,
          ).asSkeleton(),
          const Spacer(),
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: context.theme.colorScheme.accent,
                  shape: BoxShape.circle,
                ),
              ).asSkeleton(),
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  color: context.theme.colorScheme.accent,
                  borderRadius: BorderRadius.circular(8),
                ),
                height: 12,
                width: 48,
              ).asSkeleton(),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: context.theme.colorScheme.accent,
              borderRadius: BorderRadius.circular(8),
            ),
            height: 6,
            width: double.infinity,
          ).asSkeleton(),
        ],
      ),
    ).asSkeleton(),
  );
}
