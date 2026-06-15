import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/widgets/ambient_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Auto-advance to onboarding after the intro animation.
    Future.delayed(const Duration(milliseconds: 2800), () {
      if (mounted) context.go(Routes.onboarding);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AmbientBackground(
        glowAlign: Alignment.center,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo mark
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  gradient: AppColors.accentGradient,
                  borderRadius: BorderRadius.circular(26),
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.electric.withOpacity(0.5),
                        blurRadius: 40,
                        spreadRadius: 4),
                  ],
                ),
                child: const Icon(Icons.hexagon_outlined,
                    color: Colors.white, size: 46),
              )
                  .animate()
                  .scale(
                      duration: 700.ms,
                      curve: Curves.easeOutBack,
                      begin: const Offset(0.6, 0.6))
                  .fadeIn(duration: 500.ms),

              const SizedBox(height: 28),

              Text('LeadershipOS', style: AppType.display(30, weight: FontWeight.w800))
                  .animate(delay: 400.ms)
                  .fadeIn(duration: 600.ms)
                  .moveY(begin: 12, end: 0),

              const SizedBox(height: 10),

              Text('Train your mind. Lead your world.',
                      style: AppType.body(14, color: AppColors.textMuted))
                  .animate(delay: 900.ms)
                  .fadeIn(duration: 800.ms),

              const SizedBox(height: 48),

              const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: AppColors.electric),
              ).animate(delay: 1400.ms).fadeIn(),
            ],
          ),
        ),
      ),
    );
  }
}
