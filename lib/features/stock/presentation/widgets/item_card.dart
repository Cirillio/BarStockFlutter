import 'package:bar_stock/core/router/app_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter/shadcn_flutter_extension.dart';
import 'package:bar_stock/features/stock/domain/entities/product_item.dart';

class ItemCard extends StatefulWidget {
  const ItemCard({super.key, required this.item});

  final ProductItem item;

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);
    onItemPressed() => {router.push("${AppRoutes.stock}/${widget.item.id}")};

    return Button(
      style: ButtonStyle(
        variance: ButtonVariance.outline,
        density: ButtonDensity.icon,
      ),

      onPressed: onItemPressed,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            flex: 5,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              child: Container(
                color: Colors.white,
                child: Image.network(
                  widget.item.imageUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => Container(
                    color: context.theme.colorScheme.muted,
                    alignment: Alignment.center,
                    child: const Icon(Icons.image_not_supported_outlined),
                  ),
                ),
              ),
            ),
          ),

          Flexible(
            flex: 2,
            child: Column(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      widget.item.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Затычка",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: context.theme.colorScheme.accentForeground,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
