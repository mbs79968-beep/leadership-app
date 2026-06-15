import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/dummy/dummy_data.dart';
import '../../data/models/models.dart';

/// ─────────────────────────────────────────────────────────────
/// STATE MANAGEMENT
///
/// Recommendation for this app: **Riverpod** (flutter_riverpod).
/// Why Riverpod over Provider/Bloc/GetX here:
///   • Compile-safe, no BuildContext needed to read state.
///   • Scales cleanly as real backend/AI providers replace these stubs —
///     just swap the provider body, screens stay untouched.
///   • Great for derived state (e.g. live pressure → meter color).
///
/// For a larger team you could add Bloc for the Simulation engine only,
/// but Riverpod alone is the cleanest fit for a frontend of this size.
/// ─────────────────────────────────────────────────────────────

/// The signed-in user. In production this becomes an AsyncNotifier hitting auth.
final userProfileProvider =
    StateProvider<UserProfile>((ref) => DummyData.user);

/// Onboarding draft, mutated step by step then committed to [userProfileProvider].
class OnboardingState {
  final String name;
  final int age;
  final LeadershipGoal? goal;
  final String weakness;
  final ExperienceLevel? experience;

  const OnboardingState({
    this.name = '',
    this.age = 18,
    this.goal,
    this.weakness = '',
    this.experience,
  });

  OnboardingState copyWith({
    String? name,
    int? age,
    LeadershipGoal? goal,
    String? weakness,
    ExperienceLevel? experience,
  }) =>
      OnboardingState(
        name: name ?? this.name,
        age: age ?? this.age,
        goal: goal ?? this.goal,
        weakness: weakness ?? this.weakness,
        experience: experience ?? this.experience,
      );

  bool get isComplete =>
      name.isNotEmpty && goal != null && experience != null;
}

class OnboardingNotifier extends StateNotifier<OnboardingState> {
  OnboardingNotifier() : super(const OnboardingState());

  void setName(String v) => state = state.copyWith(name: v);
  void setAge(int v) => state = state.copyWith(age: v);
  void setGoal(LeadershipGoal v) => state = state.copyWith(goal: v);
  void setWeakness(String v) => state = state.copyWith(weakness: v);
  void setExperience(ExperienceLevel v) =>
      state = state.copyWith(experience: v);
}

final onboardingProvider =
    StateNotifierProvider<OnboardingNotifier, OnboardingState>(
        (ref) => OnboardingNotifier());

/// Live state for an active simulation (pressure, intensity, elapsed time).
class SimulationState {
  final Scenario scenario;
  final double pressure; // 0..100
  final double emotionalIntensity; // 0..100
  final int elapsedSeconds;
  final bool listening;

  const SimulationState({
    required this.scenario,
    required this.pressure,
    required this.emotionalIntensity,
    required this.elapsedSeconds,
    this.listening = false,
  });

  SimulationState copyWith({
    double? pressure,
    double? emotionalIntensity,
    int? elapsedSeconds,
    bool? listening,
  }) =>
      SimulationState(
        scenario: scenario,
        pressure: pressure ?? this.pressure,
        emotionalIntensity: emotionalIntensity ?? this.emotionalIntensity,
        elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
        listening: listening ?? this.listening,
      );
}

class SimulationNotifier extends StateNotifier<SimulationState> {
  SimulationNotifier(Scenario scenario)
      : super(SimulationState(
          scenario: scenario,
          pressure: scenario.basePressure.toDouble(),
          emotionalIntensity: 35,
          elapsedSeconds: 0,
        ));

  void tick() =>
      state = state.copyWith(elapsedSeconds: state.elapsedSeconds + 1);

  /// Stub: in production the AI engine drives these from the user's response.
  void onUserResponded() {
    state = state.copyWith(
      pressure: (state.pressure + 6).clamp(0, 100),
      emotionalIntensity: (state.emotionalIntensity + 12).clamp(0, 100),
    );
  }

  void toggleListening() => state = state.copyWith(listening: !state.listening);
}

/// Family provider: one simulation controller per scenario.
final simulationProvider = StateNotifierProvider.family<SimulationNotifier,
    SimulationState, Scenario>((ref, scenario) => SimulationNotifier(scenario));
