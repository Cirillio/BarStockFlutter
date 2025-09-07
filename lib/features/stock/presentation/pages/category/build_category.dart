import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:bar_stock/core/constants/state_status.dart';
import 'package:bar_stock/features/stock/presentation/states/category_list_state.dart';
import 'package:flutter_svg/svg.dart';

class BuildCategory extends StatelessWidget {
  final BuildContext context;
  final CategoryListState state;
  final Future<void> Function() load;
  const BuildCategory({
    super.key,
    required this.context,
    required this.state,
    required this.load,
  });

  @override
  Widget build(BuildContext context) {
    if (state.categoryStatus == StateStatus.submitting) {
      return Basic(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        titleSpacing: 12,
        title: const Avatar(initials: '', size: 102).asSkeleton(),
        content: const Text(
          'Category name',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ).asSkeleton(),
        titleAlignment: Alignment.center,
        contentAlignment: Alignment.center,
      );
    }

    final category = state.category;
    if (category == null) return const SizedBox.shrink();

    return Basic(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      titleSpacing: 16,
      title: SizedBox(
        height: 102,
        width: 102,
        child: category.iconUrl.isNotEmpty
            ? SvgPicture.network(
                category.iconUrl,
                fit: BoxFit.contain,
                placeholderBuilder: (context) => const Icon(LucideIcons.image),
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(LucideIcons.imageOff),
              )
            : const Icon(LucideIcons.package, size: 64),
      ),
      titleAlignment: Alignment.center,
      content: OutlineBadge(
        child: Text(
          category.name,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ).withMargin(vertical: 3, horizontal: 6),
      ),
      contentAlignment: Alignment.center,
    );
  }
}
