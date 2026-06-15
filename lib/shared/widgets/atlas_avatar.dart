import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// Stylised AI counterpart / mentor avatar.
/// A pulsing ring conveys a "live, listening" presence without a real face.
class AtlasAvatar extends StatefulWidget {
  final double size;
  final bool speaking;
  final String initial;

  const AtlasAvatar({
    super.key,
    this.size = 96,
    this.speaking = true,
    this.initial = 'A',
  });

  @override
  State<AtlasAvatar> createState() => _AtlasAvatarState();
}

class _AtlasAvatarState extends State<AtlasAvatar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c =
      AnimationController(vsync: this, duration: const Duration(seconds: 3))
        ..repeat(reverse: true);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (_, __) {
        final pulse = widget.speaking ? 0.5 + _c.value * 0.5 : 0.3;
        return Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const RadialGradient(
              colors: [AppColors.royalBlue, AppColors.obsidian],
            ),
            border: Border.all(
                color: AppColors.electric.withOpacity(0.6), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: AppColors.electric.withOpacity(0.4 * pulse),
                blurRadius: 30 * pulse,
                spreadRadius: 4 * pulse,
              ),
            ],
          ),
          child: Center(
            child: Text(
              widget.initial,
              style: AppType.display(widget.size * 0.34,
                  weight: FontWeight.w800, color: AppColors.platinum),
            ),
          ),
        );
      },
    );
  }
}
