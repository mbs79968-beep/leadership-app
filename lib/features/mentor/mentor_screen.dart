import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../data/dummy/dummy_data.dart';
import '../../data/models/models.dart';
import '../../shared/widgets/ambient_background.dart';
import '../../shared/widgets/atlas_avatar.dart';
import '../../shared/widgets/glass_card.dart';

class MentorScreen extends StatelessWidget {
  const MentorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AmbientBackground(
        glowAlign: Alignment.topCenter,
        child: SafeArea(
          bottom: false,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(AppSpace.screenPad,
                AppSpace.md, AppSpace.screenPad, 120),
            children: [
              // Header with avatar
              Column(
                children: [
                  const AtlasAvatar(size: 88)
                      .animate()
                      .scale(begin: const Offset(0.8, 0.8), duration: 500.ms),
                  const SizedBox(height: AppSpace.md),
                  Text('Atlas', style: AppType.display(24)),
                  Text('Your AI leadership mentor',
                      style: AppType.body(13, color: AppColors.textMuted)),
                ],
              ),
              const SizedBox(height: AppSpace.xl),

              // Daily advice
              const SectionHeader("Today's Counsel"),
              GlassCard(
                borderColor: AppColors.electric.withOpacity(0.3),
                child: Column(
                  children: [
                    for (int i = 0;
                        i < DummyData.atlasDailyAdvice.length;
                        i++) ...[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('0${i + 1}',
                              style: AppType.mono(13,
                                  color: AppColors.electric)),
                          const SizedBox(width: AppSpace.md),
                          Expanded(
                            child: Text(DummyData.atlasDailyAdvice[i],
                                style: AppType.body(14,
                                    color: AppColors.silver, height: 1.5)),
                          ),
                        ],
                      ),
                      if (i != DummyData.atlasDailyAdvice.length - 1)
                        const Divider(height: AppSpace.lg),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: AppSpace.lg),

              // Memory-based conversation
              const SectionHeader('Memory'),
              ...DummyData.atlasThread.map((m) => _MessageBubble(message: m)),
              const SizedBox(height: AppSpace.lg),

              // Personalized missions
              const SectionHeader('Missions for you'),
              ...DummyData.missions.map((m) => _MissionRow(mission: m)),
            ],
          ),
        ),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final MentorMessage message;
  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final fromAtlas = message.fromAtlas;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpace.sm),
      child: Align(
        alignment:
            fromAtlas ? Alignment.centerLeft : Alignment.centerRight,
        child: ConstrainedBox(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.78),
          child: Container(
            padding: const EdgeInsets.all(AppSpace.md),
            decoration: BoxDecoration(
              gradient: fromAtlas ? null : AppColors.accentGradient,
              color: fromAtlas ? AppColors.carbon : null,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(AppSpace.rMd),
                topRight: const Radius.circular(AppSpace.rMd),
                bottomLeft: Radius.circular(fromAtlas ? 4 : AppSpace.rMd),
                bottomRight: Radius.circular(fromAtlas ? AppSpace.rMd : 4),
              ),
              border: fromAtlas
                  ? Border.all(color: AppColors.steel)
                  : null,
            ),
            child: Text(message.text,
                style: AppType.body(14,
                    color: fromAtlas ? AppColors.silver : Colors.white,
                    height: 1.45)),
          ),
        ),
      ),
    );
  }
}

class _MissionRow extends StatelessWidget {
  final Mission mission;
  const _MissionRow({required this.mission});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpace.sm),
      child: GlassCard(
        padding:
            const EdgeInsets.symmetric(horizontal: AppSpace.md, vertical: 14),
        child: Row(
          children: [
            Icon(
              mission.completed
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,
              color: mission.completed
                  ? AppColors.success
                  : AppColors.textFaint,
              size: 20,
            ),
            const SizedBox(width: AppSpace.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(mission.title,
                      style: AppType.body(14,
                          weight: FontWeight.w600,
                          color: AppColors.platinum)),
                  Text(mission.description,
                      style: AppType.body(12, color: AppColors.textMuted)),
                ],
              ),
            ),
            Text('+${mission.xp}',
                style: AppType.mono(12, color: AppColors.gold)),
          ],
        ),
      ),
    );
  }
}
