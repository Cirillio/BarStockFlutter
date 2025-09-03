import 'package:bar_stock/features/stock/domain/entities/item_unit.dart';
import 'package:bar_stock/features/stock/domain/entities/product_list_item.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter/shadcn_flutter_extension.dart';

class ProductListItemCard extends StatefulWidget {
  const ProductListItemCard({super.key, required this.item});

  final ProductListItem item;

  @override
  State<ProductListItemCard> createState() => _ProductListItemCardState();
}

class _ProductListItemCardState extends State<ProductListItemCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 50),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.99).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
    _animationController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    _animationController.reverse();
  }

  void _onTapCancel() {
    setState(() => _isPressed = false);
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final isLowStock = widget.item.qty <= widget.item.minStock;
    final isDark = context.theme.brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            onTapCancel: _onTapCancel,
            onTap: () async {
              // Запускаем анимацию для быстрого тапа
              if (!_animationController.isAnimating) {
                _animationController.forward().then((_) {
                  _animationController.reverse();
                });
              }
              // Navigate to product details
              // final router = GoRouter.of(context);
              // router.push("/stock/${widget.item.id}");
            },
            child: Container(
              decoration: BoxDecoration(
                color: context.theme.colorScheme.card,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: isDark
                        ? context.theme.colorScheme.mutedForeground.withAlpha(
                            100,
                          )
                        : context.theme.colorScheme.primary.withAlpha(25),
                    blurRadius: 4,
                    offset: const Offset(0, 0.5),
                  ),
                  if (_isPressed)
                    BoxShadow(
                      color: isLowStock
                          ? context.theme.colorScheme.destructive.withAlpha(25)
                          : context.theme.colorScheme.primary.withAlpha(50),
                      blurRadius: 2,
                      spreadRadius: 0.125,
                      offset: const Offset(0, 1),
                    ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Изображение товара
                  Flexible(
                    flex: 7,
                    child: Container(
                      margin: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
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
                                    color: context
                                        .theme
                                        .colorScheme
                                        .mutedForeground,
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
                      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
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
                          const SizedBox(height: 8),

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
                                        : context
                                              .theme
                                              .colorScheme
                                              .mutedForeground,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const Spacer(),

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
                                  (widget.item.qty / (widget.item.minStock * 3))
                                      .clamp(0.0, 1.0),
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
            ),
          ),
        );
      },
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
