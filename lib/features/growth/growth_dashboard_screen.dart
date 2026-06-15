import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../data/dummy/dummy_data.dart';
import '../../shared/widgets/ambient_background.dart';
import '../../shared/widgets/charts.dart';
import '../../shared/widgets/glass_card.dart';

class GrowthDashboardScreen extends StatelessWidget {
  const GrowthDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AmbientBackground(
        child: SafeArea(
          bottom: false,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(AppSpace.screenPad,
                AppSpace.md, AppSpace.screenPad, 120),
            children: [
              Text('GROWTH', style: AppType.label(10)),
              const SizedBox(height: 4),
              Text('Your trajectory', style: AppType.display(24)),
              const SizedBox(height: AppSpace.lg),

              // Skill radar
              const SectionHeader('Skill Radar'),
              GlassCard(
                child: Column(
                  children: [
                    SkillRadarChart(skills: DummyData.skills),
                    const SizedBox(height: AppSpace.md),
                    Wrap(
                      spacing: AppSpace.sm,
                      runSpacing: AppSpace.sm,
                      alignment: WrapAlignment.center,
                      children: [
                        for (final s in DummyData.skills)
                          _SkillPill(name: s.name, value: s.value, delta: s.delta),
                      ],
                    ),
                  ],
                ),
              ).animate().fadeIn(),

              const SizedBox(height: AppSpace.lg),

              // Weekly improvement
              const SectionHeader('Weekly Improvement'),
              GlassCard(
                  child: ProgressLineChart(
                      points: DummyData.weeklyImprovement,
                      color: AppColors.success)),

              const SizedBox(height: AppSpace.lg),

              // Leadership progression
              const SectionHeader('Leadership Progression'),
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('+44 pts',
                            style: AppType.mono(20, color: AppColors.electric)),
                        const SizedBox(width: AppSpace.sm),
                        Text('over 7 weeks',
                            style: AppType.body(12, color: AppColors.textMuted)),
                      ],
                    ),
                    const SizedBox(height: AppSpace.md),
                    ProgressLineChart(points: DummyData.leadershipProgression),
                  ],
                ),
              ),

              const SizedBox(height: AppSpace.lg),

              // Weakness trends
              const SectionHeader('Weakness Trends'),
              GlassCard(
                child: Column(
                  children: [
                    _TrendRow(
                        label: 'Speaking under pressure',
                        value: 'Improving',
                        delta: '-12%',
                        positive: true),
                    const Divider(height: AppSpace.lg),
                    _TrendRow(
                        label: 'Conceding objections',
                        value: 'Watch',
                        delta: '+3%',
                        positive: false),
                    const Divider(height: AppSpace.lg),
                    _TrendRow(
                        label: 'Filler words',
                        value: 'Improving',
                        delta: '-8%',
                        positive: true),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SkillPill extends StatelessWidget {
  final String name;
  final double value;
  final double delta;
  const _SkillPill(
      {required this.name, required this.value, required this.delta});

  @override
  Widget build(BuildContext context) {
    final up = delta >= 0;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.carbon,
        borderRadius: AppSpace.radius(AppSpace.rPill),
        border: Border.all(color: AppColors.steel),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('${name.split(' ').first} ',
              style: AppType.body(12, color: AppColors.silver)),
          Text('${value.toInt()}',
              style: AppType.mono(12, color: AppColors.platinum)),
          const SizedBox(width: 4),
          Icon(up ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              size: 16,
              color: up ? AppColors.success : AppColors.danger),
        ],
      ),
    );
  }
}

class _TrendRow extends StatelessWidget {
  final String label;
  final String value;
  final String delta;
  final bool positive;
  const _TrendRow(
      {required this.label,
      required this.value,
      required this.delta,
      required this.positive});

  @override
  Widget build(BuildContext context) {
    final color = positive ? AppColors.success : AppColors.warning;
    return Row(
      children: [
        Expanded(
            child: Text(label,
                style: AppType.body(13, color: AppColors.silver))),
        Text(value, style: AppType.body(12, color: color)),
        const SizedBox(width: AppSpace.sm),
        Text(delta, style: AppType.mono(12, color: color)),
      ],
    );
  }
}
