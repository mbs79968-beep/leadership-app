import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../data/dummy/dummy_data.dart';
import '../../data/models/models.dart';
import '../../shared/widgets/ambient_background.dart';
import '../../shared/widgets/glass_card.dart';

class ScenarioLibraryScreen extends StatefulWidget {
  const ScenarioLibraryScreen({super.key});

  @override
  State<ScenarioLibraryScreen> createState() => _ScenarioLibraryScreenState();
}

class _ScenarioLibraryScreenState extends State<ScenarioLibraryScreen> {
  ScenarioCategory? _filter;

  @override
  Widget build(BuildContext context) {
    final scenarios = _filter == null
        ? DummyData.scenarios
        : DummyData.scenarios.where((s) => s.category == _filter).toList();

    return Scaffold(
      body: AmbientBackground(
        child: SafeArea(
          bottom: false,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(AppSpace.screenPad,
                AppSpace.md, AppSpace.screenPad, 120),
            children: [
              Text('SCENARIO LIBRARY', style: AppType.label(10)),
              const SizedBox(height: 4),
              Text('Choose your arena', style: AppType.display(24)),
              const SizedBox(height: AppSpace.lg),

              // Category filter row
              SizedBox(
                height: 38,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _CategoryChip(
                      label: 'All',
                      selected: _filter == null,
                      onTap: () => setState(() => _filter = null),
                    ),
                    for (final c in ScenarioCategory.values)
                      _CategoryChip(
                        label: c.label,
                        icon: c.icon,
                        selected: _filter == c,
                        onTap: () => setState(() => _filter = c),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpace.lg),

              for (int i = 0; i < scenarios.length; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpace.md),
                  child: _ScenarioCard(scenario: scenarios[i])
                      .animate(delay: (i * 60).ms)
                      .fadeIn()
                      .moveY(begin: 14, end: 0),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool selected;
  final VoidCallback onTap;
  const _CategoryChip(
      {required this.label,
      this.icon,
      required this.selected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: AppSpace.sm),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? AppColors.electric : AppColors.carbon,
            borderRadius: AppSpace.radius(AppSpace.rPill),
            border: Border.all(
                color: selected ? AppColors.electric : AppColors.steel),
          ),
          child: Row(
            children: [
              if (icon != null) ...[
                Icon(icon,
                    size: 14,
                    color: selected ? Colors.white : AppColors.textMuted),
                const SizedBox(width: 6),
              ],
              Text(label,
                  style: AppType.body(13,
                      weight: FontWeight.w600,
                      color:
                          selected ? Colors.white : AppColors.textMuted)),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScenarioCard extends StatelessWidget {
  final Scenario scenario;
  const _ScenarioCard({required this.scenario});

  Color get _diffColor => switch (scenario.difficulty) {
        Difficulty.foundational => AppColors.success,
        Difficulty.advanced => AppColors.warning,
        Difficulty.elite => AppColors.danger,
      };

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      onTap: () => context.push(Routes.simulation, extra: scenario),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.slate,
                  borderRadius: AppSpace.radius(AppSpace.rSm),
                ),
                child: Icon(scenario.category.icon,
                    color: AppColors.glowBlue, size: 22),
              ),
              const SizedBox(width: AppSpace.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(scenario.title, style: AppType.display(16)),
                    Text(scenario.category.label,
                        style: AppType.body(11, color: AppColors.textMuted)),
                  ],
                ),
              ),
              StatusChip(
                  label: scenario.difficulty.label, color: _diffColor),
            ],
          ),
          const SizedBox(height: AppSpace.md),
          Text(scenario.subtitle,
              style: AppType.body(13, color: AppColors.silver, height: 1.4)),
          const SizedBox(height: AppSpace.md),
          Row(
            children: [
              const Icon(Icons.timer_outlined,
                  size: 14, color: AppColors.textFaint),
              const SizedBox(width: 4),
              Text('${scenario.durationMin} min',
                  style: AppType.mono(11, color: AppColors.textFaint)),
              const SizedBox(width: AppSpace.md),
              const Icon(Icons.speed,
                  size: 14, color: AppColors.textFaint),
              const SizedBox(width: 4),
              Text('Pressure ${scenario.basePressure}',
                  style: AppType.mono(11, color: AppColors.textFaint)),
              const Spacer(),
              const Icon(Icons.arrow_forward,
                  size: 16, color: AppColors.electric),
            ],
          ),
        ],
      ),
    );
  }
}
