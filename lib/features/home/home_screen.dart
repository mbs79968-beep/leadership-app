import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/routes.dart';
import '../../core/state/app_providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../data/dummy/dummy_data.dart';
import '../../data/models/models.dart';
import '../../shared/widgets/ambient_background.dart';
import '../../shared/widgets/buttons.dart';
import '../../shared/widgets/charts.dart';
import '../../shared/widgets/glass_card.dart';
import '../../shared/widgets/stat_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProfileProvider);
    final mission = DummyData.missions.first;
    final scenario = DummyData.todaysScenario;

    return Scaffold(
      body: AmbientBackground(
        child: SafeArea(
          bottom: false,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(AppSpace.screenPad,
                AppSpace.md, AppSpace.screenPad, 120),
            children: [
              // ── Header ──
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('MISSION CONTROL', style: AppType.label(10)),
                        const SizedBox(height: 4),
                        Text('Welcome back, ${user.name}',
                            style: AppType.display(22)),
                      ],
                    ),
                  ),
                  _LevelBadge(level: user.level),
                ],
              ).animate().fadeIn(duration: 400.ms),

              const SizedBox(height: AppSpace.lg),

              // ── Level progress ──
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Leadership Level ${user.level}',
                            style: AppType.body(14,
                                weight: FontWeight.w700,
                                color: AppColors.platinum)),
                        const Spacer(),
                        Text('${(user.levelProgress * 100).toInt()}% to ${user.level + 1}',
                            style: AppType.mono(11, color: AppColors.electric)),
                      ],
                    ),
                    const SizedBox(height: AppSpace.sm),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: LinearProgressIndicator(
                        value: user.levelProgress,
                        minHeight: 8,
                        backgroundColor: AppColors.slate,
                        valueColor:
                            const AlwaysStoppedAnimation(AppColors.electric),
                      ),
                    ),
                  ],
                ),
              ).animate(delay: 100.ms).fadeIn().moveY(begin: 12, end: 0),

              const SizedBox(height: AppSpace.md),

              // ── Stat grid ──
              Row(
                children: [
                  Expanded(
                    child: StatCard(
                      label: 'Day Streak',
                      value: '${user.streak}',
                      icon: Icons.local_fire_department,
                      accent: AppColors.gold,
                      trailing: 'active',
                    ),
                  ),
                  const SizedBox(width: AppSpace.md),
                  Expanded(
                    child: StatCard(
                      label: 'Overall',
                      value: '74',
                      icon: Icons.trending_up,
                      trailing: '+8%',
                    ),
                  ),
                ],
              ).animate(delay: 150.ms).fadeIn(),

              const SizedBox(height: AppSpace.md),

              // ── Today's mission ──
              const SectionHeader("Today's Mission"),
              _MissionCard(mission: mission, scenario: scenario),

              const SizedBox(height: AppSpace.lg),

              // ── Quick start ──
              PrimaryButton(
                label: 'Quick Start Simulation',
                icon: Icons.play_arrow_rounded,
                onPressed: () =>
                    context.push(Routes.simulation, extra: scenario),
              ).animate(delay: 250.ms).fadeIn().scale(begin: const Offset(0.98, 0.98)),

              const SizedBox(height: AppSpace.lg),

              // ── Progress graph ──
              const SectionHeader('Progress', action: 'View all'),
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('This week', style: AppType.body(13, color: AppColors.textMuted)),
                    const SizedBox(height: AppSpace.sm),
                    ProgressLineChart(points: DummyData.weeklyImprovement),
                  ],
                ),
              ),

              const SizedBox(height: AppSpace.lg),

              // ── AI mentor insight ──
              const SectionHeader('Atlas Insight'),
              _AtlasInsightCard(),

              const SizedBox(height: AppSpace.lg),

              // ── Recent improvements ──
              const SectionHeader('Recent Improvements'),
              ...DummyData.recentImprovements.map((t) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpace.sm),
                    child: GlassCard(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSpace.md, vertical: 12),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle,
                              color: AppColors.success, size: 18),
                          const SizedBox(width: AppSpace.sm),
                          Expanded(
                              child: Text(t,
                                  style: AppType.body(13,
                                      color: AppColors.silver))),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class _LevelBadge extends StatelessWidget {
  final int level;
  const _LevelBadge({required this.level});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        gradient: AppColors.accentGradient,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
              color: AppColors.electric.withOpacity(0.4),
              blurRadius: 18,
              spreadRadius: -2),
        ],
      ),
      child: Center(
        child: Text('$level',
            style: AppType.mono(20, color: Colors.white)),
      ),
    );
  }
}

class _MissionCard extends StatelessWidget {
  final Mission mission;
  final Scenario scenario;
  const _MissionCard({required this.mission, required this.scenario});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderColor: AppColors.electric.withOpacity(0.35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              StatusChip(
                  label: mission.category.label,
                  color: AppColors.electric,
                  icon: mission.category.icon),
              const Spacer(),
              Text('+${mission.xp} XP',
                  style: AppType.mono(12, color: AppColors.gold)),
            ],
          ),
          const SizedBox(height: AppSpace.md),
          Text(mission.title, style: AppType.display(18)),
          const SizedBox(height: 6),
          Text(mission.description,
              style: AppType.body(13, color: AppColors.textMuted)),
          const SizedBox(height: AppSpace.md),
          GhostButton(
            label: 'Start mission',
            icon: Icons.flag_outlined,
            onPressed: () =>
                context.push(Routes.simulation, extra: scenario),
          ),
        ],
      ),
    ).animate(delay: 200.ms).fadeIn().moveY(begin: 14, end: 0);
  }
}

class _AtlasInsightCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                  colors: [AppColors.royalBlue, AppColors.obsidian]),
            ),
            child: const Icon(Icons.auto_awesome,
                color: AppColors.glowBlue, size: 18),
          ),
          const SizedBox(width: AppSpace.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Atlas',
                    style: AppType.body(13,
                        weight: FontWeight.w700,
                        color: AppColors.platinum)),
                const SizedBox(height: 4),
                Text(DummyData.atlasDailyAdvice.first,
                    style: AppType.body(13,
                        color: AppColors.silver, height: 1.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
