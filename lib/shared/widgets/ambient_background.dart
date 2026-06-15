import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Atmospheric backdrop: deep-blue radial spotlight over the void.
/// Wrap any screen body with this for the "in the room" depth.
class AmbientBackground extends StatelessWidget {
  final Widget child;
  final Alignment glowAlign;

  const AmbientBackground({
    super.key,
    required this.child,
    this.glowAlign = const Alignment(0, -0.7),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppColors.voidBlack),
      child: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: glowAlign,
                  radius: 1.1,
                  colors: [
                    AppColors.deepBlue.withOpacity(0.45),
                    AppColors.voidBlack,
                  ],
                ),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
