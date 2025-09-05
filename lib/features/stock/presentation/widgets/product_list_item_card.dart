import 'package:bar_stock/features/stock/domain/entities/item_unit.dart';
import 'package:bar_stock/features/stock/domain/entities/product_list_item.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter/shadcn_flutter_extension.dart';
import 'package:bar_stock/core/shared_ui/widgets/item_card.dart';

class ProductListItemCard extends StatefulWidget {
  const ProductListItemCard({super.key, required this.item});

  final ProductListItem item;

  @override
  State<ProductListItemCard> createState() => _ProductListItemCardState();
}

class _ProductListItemCardState extends State<ProductListItemCard> {
  @override
  Widget build(BuildContext context) {
    final isLowStock = widget.item.qty <= widget.item.minStock;
    final isDark = context.theme.brightness == Brightness.dark;

    return ItemCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Изображение товара
          Flexible(
            flex: 7,
            child: Container(
              margin: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(context.theme.radiusMd),
                color: Colors.white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(context.theme.radiusMd),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.network(
                        widget.item.imageUrl,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => Container(
                          color: context.theme.colorScheme.muted,
                          child: Icon(
                            LucideIcons.image,
                            size: 32,
                            color: context.theme.colorScheme.mutedForeground,
                          ),
                        ),
                      ),
                    ),
                    // Индикатор низких остатков
                    if (isLowStock)
                      Positioned(
                        top: 4,
                        right: 4,
                        child: Icon(
                          LucideIcons.triangleAlert,
                          size: 20,
                          color: isDark
                              ? context.theme.colorScheme.chart5
                              : context.theme.colorScheme.destructive,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),

          // Информация о товаре
          Flexible(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(6, 0, 6, 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Название
                  Text(
                    widget.item.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                  ),

                  const Spacer(),

                  // Остаток с индикатором
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
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${widget.item.qty.toStringAsFixed(widget.item.qty % 1 == 0 ? 0 : 1)} ${_getUnitName(widget.item.unit)}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: isLowStock
                                ? context.theme.colorScheme.destructive
                                : context.theme.colorScheme.mutedForeground,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // Мини прогресс-бар остатков
                  Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: context.theme.colorScheme.muted,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor:
                          (widget.item.qty / (widget.item.minStock * 3)).clamp(
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
            ),
          ),
        ],
      ),
    );
  }

  Color _getStockColor(BuildContext context) {
    final ratio = widget.item.qty / widget.item.minStock;
    if (ratio <= 1) return context.theme.colorScheme.destructive;
    if (ratio <= 2) return Colors.orange;
    return context.theme.colorScheme.chart2;
  }
}

String _getUnitName(ItemUnit unit) {
  return unit.displayName;
}
