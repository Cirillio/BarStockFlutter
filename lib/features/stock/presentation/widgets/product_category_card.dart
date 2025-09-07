import 'package:bar_stock/core/shared_ui/widgets/item_card.dart';
import 'package:bar_stock/features/stock/domain/entities/item_unit.dart';
import 'package:bar_stock/features/stock/domain/entities/product_list_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter/shadcn_flutter_extension.dart';

class ProductCategoryCard extends StatelessWidget {
  const ProductCategoryCard({super.key, required this.item});

  final ProductListItem item;

  @override
  Widget build(BuildContext context) {
    final isLowStock = item.qty <= item.minStock;

    return SizedBox(
      height: 102,
      child: ItemCard(
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1.0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(context.theme.radiusMd),
                    color: Colors.white,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(context.theme.radiusMd),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: CachedNetworkImage(
                            imageUrl: item.imageUrl,
                            memCacheWidth: 248,
                            fit: BoxFit.contain,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(LucideIcons.imageOff),
                          ).withOpacity(isLowStock ? 0.5 : 1),
                        ),
                        if (isLowStock)
                          Positioned(
                            top: 0,
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Icon(
                              LucideIcons.circleAlert,
                              size: 32,
                              color: Colors.red,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        item.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                        ),
                      ),
                    ),

                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: isLowStock
                                    ? context.theme.colorScheme.destructive
                                    : context.theme.colorScheme.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 3),
                            Text(
                              '${item.qty.toStringAsFixed(item.qty % 1 == 0 ? 0 : 1)} ${item.unit.displayName}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: isLowStock
                                    ? context.theme.colorScheme.destructive
                                    : context.theme.colorScheme.mutedForeground,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 3),

                        Container(
                          height: 4,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: context.theme.colorScheme.muted,
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: (item.qty / (item.minStock * 3)).clamp(
                              0.0,
                              1.0,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: _getStockColor(context),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ).withPadding(horizontal: 12, vertical: 6),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStockColor(BuildContext context) {
    final ratio = item.qty / item.minStock;
    if (ratio <= 1) return context.theme.colorScheme.destructive;
    if (ratio <= 2) return Colors.orange;
    return context.theme.colorScheme.chart2;
  }
}
