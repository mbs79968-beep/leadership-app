import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_theme.dart';

/// Reusable frosted surface used across nearly every screen.
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final Color? borderColor;
  final VoidCallback? onTap;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpace.md),
    this.radius = AppSpace.rMd,
    this.borderColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final content = Container(
      padding: padding,
      decoration: AppTheme.glass(radius: radius, border: borderColor),
      child: child,
    );
    if (onTap == null) return content;
    return Material(
      color: Colors.transparent,
      child: InkWell(
          borderRadius: AppSpace.radius(radius), onTap: onTap, child: content),
    );
  }
}

/// "OVERVIEW", "TODAY'S MISSION" etc. — tracked uppercase label + optional action.
class SectionHeader extends StatelessWidget {
  final String title;
  final String? action;
  final VoidCallback? onAction;

  const SectionHeader(this.title, {super.key, this.action, this.onAction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpace.md, top: AppSpace.sm),
      child: Row(
        children: [
          Container(
            width: 3,
            height: 14,
            margin: const EdgeInsets.only(right: AppSpace.sm),
            decoration: BoxDecoration(
              gradient: AppColors.accentGradient,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Text(title.toUpperCase(), style: AppType.label(11)),
          const Spacer(),
          if (action != null)
            GestureDetector(
              onTap: onAction,
              child: Text(action!,
                  style: AppType.body(12,
                      weight: FontWeight.w600, color: AppColors.electric)),
            ),
        ],
      ),
    );
  }
}

/// Small status chip (difficulty, category, live status).
class StatusChip extends StatelessWidget {
  final String label;
  final Color color;
  final IconData? icon;

  const StatusChip(
      {super.key, required this.label, required this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: AppSpace.radius(AppSpace.rPill),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: color),
            const SizedBox(width: 4),
          ],
          Text(label.toUpperCase(),
              style: AppType.label(9.5, color: color)),
        ],
      ),
    );
  }
}
