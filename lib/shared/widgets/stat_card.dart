import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import 'glass_card.dart';

/// Compact metric tile (Level, Streak, etc.) used on the Home grid.
class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color accent;
  final String? trailing;

  const StatCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.accent = AppColors.electric,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: accent, size: 18),
              const Spacer(),
              if (trailing != null)
                Text(trailing!,
                    style: AppType.mono(11, color: AppColors.success)),
            ],
          ),
          const SizedBox(height: AppSpace.md),
          Text(value, style: AppType.mono(24, color: AppColors.platinum)),
          const SizedBox(height: 2),
          Text(label.toUpperCase(), style: AppType.label(9.5)),
        ],
      ),
    );
  }
}

/// Horizontal animated bar used for pressure / emotional intensity / scores.
class IntensityMeter extends StatelessWidget {
  final String label;
  final double value; // 0..100
  final Color? color;
  final bool showValue;

  const IntensityMeter({
    super.key,
    required this.label,
    required this.value,
    this.color,
    this.showValue = true,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.intensity(value);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label.toUpperCase(), style: AppType.label(9.5)),
            const Spacer(),
            if (showValue)
              Text('${value.toInt()}', style: AppType.mono(11, color: c)),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Stack(
            children: [
              Container(height: 8, color: AppColors.slate),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: value.clamp(0, 100) / 100),
                duration: const Duration(milliseconds: 700),
                curve: Curves.easeOutCubic,
                builder: (_, v, __) => FractionallySizedBox(
                  widthFactor: v,
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [c.withOpacity(0.6), c]),
                      boxShadow: [
                        BoxShadow(
                            color: c.withOpacity(0.6),
                            blurRadius: 8,
                            spreadRadius: -2),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
