import 'package:shadcn_flutter/shadcn_flutter.dart';

// Скелетон для одной карточки товара
Widget buildProductCardSkeleton() {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Изображение товара (квадратное)
          AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            ).asSkeleton(),
          ),

          const SizedBox(height: 12),

          // Название товара
          SizedBox(height: 16, width: double.infinity).asSkeleton(),

          const SizedBox(height: 8),

          // Вторая строка названия (если длинное)
          SizedBox(height: 16, width: 120).asSkeleton(),

          const SizedBox(height: 12),

          // Количество в бутылках
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(shape: BoxShape.circle),
              ).asSkeleton(),
              const SizedBox(width: 8),
              SizedBox(height: 12, width: 60).asSkeleton(),
            ],
          ),

          const SizedBox(height: 8),

          // Цветная полоска индикатора
          Container(
            height: 4,
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(2)),
          ).asSkeleton(),
        ],
      ),
    ),
  );
}

// Скелетон для заголовка категории
Widget buildCategoryHeaderSkeleton() {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: SizedBox(height: 24, width: 120).asSkeleton(),
  );
}

// Полный скелетон страницы категории
Widget buildCategoryPageSkeleton() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Заголовок категории
      buildCategoryHeaderSkeleton(),

      // Сетка товаров
      Expanded(
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: 6, // Показываем 6 скелетонов
          itemBuilder: (context, index) => buildProductCardSkeleton(),
        ),
      ),
    ],
  );
}
