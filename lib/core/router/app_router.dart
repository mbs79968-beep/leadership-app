import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/routes.dart';
import '../../data/models/models.dart';
import '../../data/dummy/dummy_data.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/library/scenario_library_screen.dart';
import '../../features/growth/growth_dashboard_screen.dart';
import '../../features/mentor/mentor_screen.dart';
import '../../features/simulation/simulation_screen.dart';
import '../../features/feedback/feedback_screen.dart';
import '../../shared/widgets/app_shell.dart';

/// App navigation. Splash + onboarding sit outside the shell; the four primary
/// destinations live inside a persistent bottom-nav [AppShell]; simulation and
/// feedback are full-screen flows pushed on top.
class AppRouter {
  AppRouter._();

  static final _rootKey = GlobalKey<NavigatorState>();
  static final _shellKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootKey,
    initialLocation: Routes.splash,
    routes: [
      GoRoute(
        path: Routes.splash,
        builder: (_, __) => const SplashScreen(),
      ),
      GoRoute(
        path: Routes.onboarding,
        builder: (_, __) => const OnboardingScreen(),
      ),

      // Persistent bottom-nav shell.
      ShellRoute(
        navigatorKey: _shellKey,
        builder: (_, __, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: Routes.home,
            pageBuilder: (_, __) => _noAnim(const HomeScreen()),
          ),
          GoRoute(
            path: Routes.library,
            pageBuilder: (_, __) => _noAnim(const ScenarioLibraryScreen()),
          ),
          GoRoute(
            path: Routes.growth,
            pageBuilder: (_, __) => _noAnim(const GrowthDashboardScreen()),
          ),
          GoRoute(
            path: Routes.mentor,
            pageBuilder: (_, __) => _noAnim(const MentorScreen()),
          ),
        ],
      ),

      // Full-screen flows.
      GoRoute(
        path: Routes.simulation,
        parentNavigatorKey: _rootKey,
        builder: (_, state) {
          final scenario = state.extra as Scenario? ?? DummyData.scenarios.first;
          return SimulationScreen(scenario: scenario);
        },
      ),
      GoRoute(
        path: Routes.feedback,
        parentNavigatorKey: _rootKey,
        builder: (_, state) {
          final result =
              state.extra as FeedbackResult? ?? DummyData.sampleFeedback;
          return FeedbackScreen(result: result);
        },
      ),
    ],
  );

  static CustomTransitionPage _noAnim(Widget child) => CustomTransitionPage(
        child: child,
        transitionDuration: const Duration(milliseconds: 200),
        transitionsBuilder: (_, anim, __, c) =>
            FadeTransition(opacity: anim, child: c),
      );
}
