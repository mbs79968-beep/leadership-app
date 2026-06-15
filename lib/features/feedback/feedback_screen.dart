import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../data/models/models.dart';
import '../../shared/widgets/ambient_background.dart';
import '../../shared/widgets/buttons.dart';
import '../../shared/widgets/charts.dart';
import '../../shared/widgets/glass_card.dart';
import '../../shared/widgets/stat_card.dart';

class FeedbackScreen extends StatelessWidget {
  final FeedbackResult result;
  const FeedbackScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final scores = <(String, double)>[
      ('Confidence', result.confidence),
      ('Persuasion', result.persuasion),
      ('Emotional Control', result.emotionalControl),
      ('Clarity', result.clarity),
      ('Leadership Impact', result.leadershipImpact),
    ];

    return Scaffold(
      body: AmbientBackground(
        glowAlign: Alignment.topCenter,
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(AppSpace.screenPad,
                AppSpace.md, AppSpace.screenPad, AppSpace.xl),
            children: [
              Row(
                children: [
                  Text('DEBRIEF', style: AppType.label(11)),
                  const Spacer(),
                  IconButton(
                    onPressed: () => context.go(Routes.home),
                    icon: const Icon(Icons.home_outlined,
                        color: AppColors.silver),
                  ),
                ],
              ),
              const SizedBox(height: AppSpace.sm),
              Text(result.scenarioTitle, style: AppType.display(24)),
              const SizedBox(height: AppSpace.lg),

              // ── Overall ring ──
              Center(
                child: ScoreRing(
                        value: result.overall, label: 'Overall', size: 150)
                    .animate()
                    .scale(
                        duration: 600.ms,
                        curve: Curves.easeOutBack,
                        begin: const Offset(0.7, 0.7)),
              ),
              const SizedBox(height: AppSpace.xl),

              // ── Score breakdown ──
              const SectionHeader('Score Breakdown'),
              GlassCard(
                child: Column(
                  children: [
                    for (int i = 0; i < scores.length; i++) ...[
                      IntensityMeter(
                        label: scores[i].$1,
                        value: scores[i].$2,
                        color: AppColors.intensity(100 - scores[i].$2),
                      ),
                      if (i != scores.length - 1)
                        const SizedBox(height: AppSpace.md),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: AppSpace.lg),

              // ── Mentor summary ──
              const SectionHeader('Atlas Summary'),
              GlassCard(
                borderColor: AppColors.electric.withOpacity(0.3),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.auto_awesome,
                        color: AppColors.glowBlue, size: 18),
                    const SizedBox(width: AppSpace.sm),
                    Expanded(
                      child: Text(result.mentorSummary,
                          style: AppType.body(14,
                              color: AppColors.silver, height: 1.6)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpace.lg),

              // ── Mistakes ──
              const SectionHeader('Where you slipped'),
              ...result.mistakes.map((m) => _Bullet(
                  text: m,
                  icon: Icons.close_rounded,
                  color: AppColors.danger)),
              const SizedBox(height: AppSpace.md),

              // ── Improvements ──
              const SectionHeader('Suggested improvements'),
              ...result.improvements.map((m) => _Bullet(
                  text: m,
                  icon: Icons.arrow_upward_rounded,
                  color: AppColors.success)),

              const SizedBox(height: AppSpace.xl),
              PrimaryButton(
                label: 'Run it again',
                icon: Icons.replay,
                onPressed: () => context.go(Routes.home),
              ),
              const SizedBox(height: AppSpace.sm),
              GhostButton(
                label: 'Back to Mission Control',
                onPressed: () => context.go(Routes.home),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  const _Bullet(
      {required this.text, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpace.sm),
      child: GlassCard(
        padding:
            const EdgeInsets.symmetric(horizontal: AppSpace.md, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 14, color: color),
            ),
            const SizedBox(width: AppSpace.sm),
            Expanded(
                child: Text(text,
                    style: AppType.body(13,
                        color: AppColors.silver, height: 1.4))),
          ],
        ),
      ),
    );
  }
}
