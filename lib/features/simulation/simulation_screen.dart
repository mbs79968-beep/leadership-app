import 'dart:async';
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
import '../../shared/widgets/atlas_avatar.dart';
import '../../shared/widgets/glass_card.dart';
import '../../shared/widgets/stat_card.dart';

class SimulationScreen extends ConsumerStatefulWidget {
  final Scenario scenario;
  const SimulationScreen({super.key, required this.scenario});

  @override
  ConsumerState<SimulationScreen> createState() => _SimulationScreenState();
}

class _SimulationScreenState extends ConsumerState<SimulationScreen> {
  Timer? _timer;
  final _input = TextEditingController();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      ref.read(simulationProvider(widget.scenario).notifier).tick();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _input.dispose();
    super.dispose();
  }

  String _clock(int s) =>
      '${(s ~/ 60).toString().padLeft(2, '0')}:${(s % 60).toString().padLeft(2, '0')}';

  void _send() {
    if (_input.text.trim().isEmpty) return;
    ref.read(simulationProvider(widget.scenario).notifier).onUserResponded();
    _input.clear();
    FocusScope.of(context).unfocus();
  }

  void _end() {
    context.pushReplacement(Routes.feedback,
        extra: DummyData.sampleFeedback);
  }

  @override
  Widget build(BuildContext context) {
    final sim = ref.watch(simulationProvider(widget.scenario));

    return Scaffold(
      body: AmbientBackground(
        glowAlign: const Alignment(0, -0.5),
        child: SafeArea(
          child: Column(
            children: [
              // ── Top bar: scenario title + timer + exit ──
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpace.screenPad, vertical: AppSpace.sm),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => context.pop(),
                      icon: const Icon(Icons.close, color: AppColors.silver),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          StatusChip(
                              label: 'LIVE SIMULATION',
                              color: AppColors.danger,
                              icon: Icons.circle),
                          const SizedBox(height: 4),
                          Text(widget.scenario.title,
                              style: AppType.display(16),
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.carbon,
                        borderRadius: AppSpace.radius(AppSpace.rPill),
                        border: Border.all(color: AppColors.steel),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.timer_outlined,
                              size: 14, color: AppColors.textMuted),
                          const SizedBox(width: 4),
                          Text(_clock(sim.elapsedSeconds),
                              style: AppType.mono(13)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // ── Meters ──
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpace.screenPad),
                child: Row(
                  children: [
                    Expanded(
                      child: IntensityMeter(
                          label: 'Pressure', value: sim.pressure),
                    ),
                    const SizedBox(width: AppSpace.lg),
                    Expanded(
                      child: IntensityMeter(
                          label: 'Emotional Intensity',
                          value: sim.emotionalIntensity),
                    ),
                  ],
                ),
              ),

              // ── Stage: AI counterpart ──
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSpace.screenPad),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AtlasAvatar(size: 110, speaking: !sim.listening)
                          .animate(onPlay: (c) => c.repeat(reverse: true))
                          .moveY(
                              begin: -4,
                              end: 4,
                              duration: 2500.ms,
                              curve: Curves.easeInOut),
                      const SizedBox(height: AppSpace.lg),
                      GlassCard(
                        borderColor: AppColors.electric.withOpacity(0.3),
                        child: Column(
                          children: [
                            Text('THE COUNTERPART',
                                style: AppType.label(9.5)),
                            const SizedBox(height: AppSpace.sm),
                            Text(
                              '"${widget.scenario.mentorOpener}"',
                              textAlign: TextAlign.center,
                              style: AppType.body(15,
                                  color: AppColors.platinum, height: 1.5),
                            ),
                          ],
                        ),
                      ).animate().fadeIn(delay: 300.ms),
                    ],
                  ),
                ),
              ),

              // ── Response input + voice ──
              Container(
                padding: const EdgeInsets.fromLTRB(AppSpace.screenPad,
                    AppSpace.md, AppSpace.screenPad, AppSpace.md),
                decoration: const BoxDecoration(
                  color: AppColors.obsidian,
                  border:
                      Border(top: BorderSide(color: AppColors.steel, width: 1)),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _input,
                            minLines: 1,
                            maxLines: 4,
                            style: AppType.body(15,
                                color: AppColors.platinum),
                            cursorColor: AppColors.electric,
                            decoration: InputDecoration(
                              hintText: 'Respond to hold the room…',
                              hintStyle: AppType.body(14,
                                  color: AppColors.textFaint),
                              filled: true,
                              fillColor: AppColors.carbon,
                              contentPadding: const EdgeInsets.all(14),
                              border: OutlineInputBorder(
                                borderRadius: AppSpace.radius(AppSpace.rMd),
                                borderSide:
                                    const BorderSide(color: AppColors.steel),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: AppSpace.radius(AppSpace.rMd),
                                borderSide:
                                    const BorderSide(color: AppColors.steel),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: AppSpace.radius(AppSpace.rMd),
                                borderSide: const BorderSide(
                                    color: AppColors.electric, width: 1.5),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpace.sm),
                        _VoiceButton(
                          listening: sim.listening,
                          onTap: () => ref
                              .read(simulationProvider(widget.scenario)
                                  .notifier)
                              .toggleListening(),
                        ),
                        const SizedBox(width: AppSpace.sm),
                        _SendButton(onTap: _send),
                      ],
                    ),
                    const SizedBox(height: AppSpace.sm),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: _end,
                        child: Text('End & get feedback',
                            style: AppType.body(13,
                                weight: FontWeight.w600,
                                color: AppColors.textMuted)),
                      ),
                    ),
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

class _VoiceButton extends StatelessWidget {
  final bool listening;
  final VoidCallback onTap;
  const _VoiceButton({required this.listening, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final w = Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: listening ? AppColors.danger : AppColors.carbon,
        shape: BoxShape.circle,
        border: Border.all(
            color: listening ? AppColors.danger : AppColors.steel),
        boxShadow: listening
            ? [
                BoxShadow(
                    color: AppColors.danger.withOpacity(0.5),
                    blurRadius: 18,
                    spreadRadius: 2)
              ]
            : null,
      ),
      child: Icon(listening ? Icons.mic : Icons.mic_none,
          color: listening ? Colors.white : AppColors.silver, size: 22),
    );
    return GestureDetector(
      onTap: onTap,
      child: listening
          ? w.animate(onPlay: (c) => c.repeat(reverse: true)).scale(
              begin: const Offset(1, 1),
              end: const Offset(1.08, 1.08),
              duration: 600.ms)
          : w,
    );
  }
}

class _SendButton extends StatelessWidget {
  final VoidCallback onTap;
  const _SendButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          gradient: AppColors.accentGradient,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: AppColors.electric.withOpacity(0.5),
                blurRadius: 16,
                spreadRadius: -2),
          ],
        ),
        child: const Icon(Icons.arrow_upward, color: Colors.white, size: 22),
      ),
    );
  }
}
