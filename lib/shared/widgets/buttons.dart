import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_theme.dart';

/// High-status primary action button with gradient fill + glow.
class PrimaryButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool expand;
  final bool loading;

  const PrimaryButton({
    super.key,
    required this.label,
    this.icon,
    this.onPressed,
    this.expand = true,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    final btn = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.lg),
      decoration: BoxDecoration(
        gradient: AppColors.accentGradient,
        borderRadius: AppSpace.radius(AppSpace.rMd),
        boxShadow: AppTheme.glow(AppColors.electric, blur: 28),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
        children: [
          if (loading)
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                  strokeWidth: 2, color: Colors.white),
            )
          else ...[
            if (icon != null) ...[
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(width: AppSpace.sm),
            ],
            Text(label,
                style: AppType.body(15,
                    weight: FontWeight.w700, color: Colors.white)),
          ],
        ],
      ),
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: AppSpace.radius(AppSpace.rMd),
        onTap: loading ? null : onPressed,
        child: btn,
      ),
    );
  }
}

/// Outlined / ghost button for secondary actions.
class GhostButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;

  const GhostButton(
      {super.key, required this.label, this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: AppSpace.radius(AppSpace.rMd),
        onTap: onPressed,
        child: Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: AppSpace.lg),
          decoration: BoxDecoration(
            color: AppColors.carbon,
            borderRadius: AppSpace.radius(AppSpace.rMd),
            border: Border.all(color: AppColors.steel),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, color: AppColors.silver, size: 18),
                const SizedBox(width: AppSpace.sm),
              ],
              Text(label,
                  style: AppType.body(14,
                      weight: FontWeight.w600, color: AppColors.silver)),
            ],
          ),
        ),
      ),
    );
  }
}
