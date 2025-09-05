import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter/shadcn_flutter_extension.dart';

class ItemCard extends StatefulWidget {
  const ItemCard({super.key, required this.child, this.goTo = ""});

  final Widget child;
  final String goTo;

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard>
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
            },
            child: Container(
              decoration: BoxDecoration(
                color: context.theme.colorScheme.card,
                borderRadius: BorderRadius.circular(context.theme.radiusMd),
                border: Border.all(color: context.theme.colorScheme.border),
              ),
              child: widget.child,
            ).withOpacity(_isPressed ? 0.97 : 1.0),
          ),
        );
      },
    );
  }
}
