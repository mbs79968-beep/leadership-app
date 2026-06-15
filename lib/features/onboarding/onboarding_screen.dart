import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/routes.dart';
import '../../core/state/app_providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../data/models/models.dart';
import '../../shared/widgets/ambient_background.dart';
import '../../shared/widgets/buttons.dart';
import '../../shared/widgets/glass_card.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _controller = PageController();
  int _page = 0;
  static const _total = 5;

  void _next() {
    if (_page < _total - 1) {
      _controller.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      // Commit draft → user profile, then enter the app.
      final draft = ref.read(onboardingProvider);
      ref.read(userProfileProvider.notifier).update((u) => u.copyWith(
            name: draft.name.isEmpty ? u.name : draft.name,
            age: draft.age,
            goal: draft.goal,
            weakness: draft.weakness,
            experience: draft.experience,
          ));
      context.go(Routes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final draft = ref.watch(onboardingProvider);

    return Scaffold(
      body: AmbientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpace.screenPad),
            child: Column(
              children: [
                // Progress dots
                Row(
                  children: [
                    for (int i = 0; i < _total; i++)
                      Expanded(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          height: 4,
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          decoration: BoxDecoration(
                            color: i <= _page
                                ? AppColors.electric
                                : AppColors.steel,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpace.xl),
                Expanded(
                  child: PageView(
                    controller: _controller,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (i) => setState(() => _page = i),
                    children: [
                      _NameStep(
                        value: draft.name,
                        onChanged:
                            ref.read(onboardingProvider.notifier).setName,
                      ),
                      _AgeStep(
                        value: draft.age,
                        onChanged: ref.read(onboardingProvider.notifier).setAge,
                      ),
                      _GoalStep(
                        selected: draft.goal,
                        onSelect:
                            ref.read(onboardingProvider.notifier).setGoal,
                      ),
                      _WeaknessStep(
                        value: draft.weakness,
                        onChanged:
                            ref.read(onboardingProvider.notifier).setWeakness,
                      ),
                      _ExperienceStep(
                        selected: draft.experience,
                        onSelect: ref
                            .read(onboardingProvider.notifier)
                            .setExperience,
                      ),
                    ],
                  ),
                ),
                PrimaryButton(
                  label: _page == _total - 1 ? 'Enter the room' : 'Continue',
                  icon: _page == _total - 1
                      ? Icons.login
                      : Icons.arrow_forward,
                  onPressed: _next,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StepScaffold extends StatelessWidget {
  final String step;
  final String title;
  final String subtitle;
  final Widget child;

  const _StepScaffold({
    required this.step,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(step, style: AppType.label(11, color: AppColors.electric)),
        const SizedBox(height: AppSpace.md),
        Text(title, style: AppType.display(26)),
        const SizedBox(height: AppSpace.sm),
        Text(subtitle, style: AppType.body(14, color: AppColors.textMuted)),
        const SizedBox(height: AppSpace.xl),
        Expanded(child: SingleChildScrollView(child: child)),
      ],
    );
  }
}

class _NameStep extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;
  const _NameStep({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return _StepScaffold(
      step: 'STEP 01',
      title: 'What should Atlas call you?',
      subtitle: 'Your mentor will address you by name throughout training.',
      child: _Field(hint: 'Your name', initial: value, onChanged: onChanged),
    );
  }
}

class _AgeStep extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;
  const _AgeStep({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return _StepScaffold(
      step: 'STEP 02',
      title: 'How old are you?',
      subtitle: 'We calibrate scenario intensity to your stage of life.',
      child: Column(
        children: [
          Text('$value',
              style: AppType.mono(56, color: AppColors.platinum)),
          Slider(
            value: value.toDouble(),
            min: 14,
            max: 70,
            activeColor: AppColors.electric,
            inactiveColor: AppColors.steel,
            onChanged: (v) => onChanged(v.round()),
          ),
        ],
      ),
    );
  }
}

class _GoalStep extends StatelessWidget {
  final LeadershipGoal? selected;
  final ValueChanged<LeadershipGoal> onSelect;
  const _GoalStep({required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return _StepScaffold(
      step: 'STEP 03',
      title: 'What is your primary goal?',
      subtitle: 'This shapes which missions Atlas prioritises for you.',
      child: Column(
        children: [
          for (final g in LeadershipGoal.values)
            _SelectTile(
              label: g.label,
              selected: selected == g,
              onTap: () => onSelect(g),
            ),
        ],
      ),
    );
  }
}

class _WeaknessStep extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;
  const _WeaknessStep({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return _StepScaffold(
      step: 'STEP 04',
      title: 'What is your biggest weakness?',
      subtitle: 'Be honest — Atlas trains hardest where you are weakest.',
      child: _Field(
        hint: 'e.g. Freezing under pressure',
        initial: value,
        onChanged: onChanged,
        maxLines: 3,
      ),
    );
  }
}

class _ExperienceStep extends StatelessWidget {
  final ExperienceLevel? selected;
  final ValueChanged<ExperienceLevel> onSelect;
  const _ExperienceStep({required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return _StepScaffold(
      step: 'STEP 05',
      title: 'Your leadership experience?',
      subtitle: 'Sets your starting difficulty and level.',
      child: Column(
        children: [
          for (final e in ExperienceLevel.values)
            _SelectTile(
              label: e.label,
              selected: selected == e,
              onTap: () => onSelect(e),
            ),
        ],
      ),
    );
  }
}

// ── Small shared inputs ──────────────────────────────────────────────
class _Field extends StatelessWidget {
  final String hint;
  final String initial;
  final ValueChanged<String> onChanged;
  final int maxLines;

  const _Field({
    required this.hint,
    required this.initial,
    required this.onChanged,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initial,
      onChanged: onChanged,
      maxLines: maxLines,
      style: AppType.body(16, color: AppColors.platinum),
      cursorColor: AppColors.electric,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppType.body(15, color: AppColors.textFaint),
        filled: true,
        fillColor: AppColors.carbon,
        contentPadding: const EdgeInsets.all(AppSpace.md),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppSpace.radius(AppSpace.rMd),
          borderSide: const BorderSide(color: AppColors.steel),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppSpace.radius(AppSpace.rMd),
          borderSide: const BorderSide(color: AppColors.electric, width: 1.5),
        ),
      ),
    );
  }
}

class _SelectTile extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _SelectTile({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpace.sm),
      child: GlassCard(
        onTap: onTap,
        borderColor: selected ? AppColors.electric : AppColors.steel,
        child: Row(
          children: [
            Expanded(
              child: Text(label,
                  style: AppType.body(15,
                      weight: FontWeight.w600,
                      color: selected
                          ? AppColors.platinum
                          : AppColors.silver)),
            ),
            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              color: selected ? AppColors.electric : AppColors.textFaint,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
