import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'app_spacing.dart';

/// Single dark theme for the whole app. There is intentionally no light theme:
/// LeadershipOS is always "in the room".
class AppTheme {
  AppTheme._();

  static ThemeData get dark {
    final base = ThemeData.dark(useMaterial3: true);

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.voidBlack,
      colorScheme: const ColorScheme.dark(
        surface: AppColors.obsidian,
        primary: AppColors.electric,
        secondary: AppColors.glowBlue,
        error: AppColors.danger,
        onPrimary: Colors.white,
        onSurface: AppColors.platinum,
      ),
      textTheme: GoogleFonts.manropeTextTheme(base.textTheme).apply(
        bodyColor: AppColors.silver,
        displayColor: AppColors.platinum,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: AppColors.silver),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.steel,
        thickness: 1,
        space: 1,
      ),
      iconTheme: const IconThemeData(color: AppColors.silver),
      splashColor: AppColors.electric.withOpacity(0.08),
      highlightColor: AppColors.electric.withOpacity(0.04),
    );
  }

  /// Reusable card decoration: glass surface + hairline border.
  static BoxDecoration glass({double radius = AppSpace.rMd, Color? border}) {
    return BoxDecoration(
      gradient: AppColors.surfaceGradient,
      borderRadius: AppSpace.radius(radius),
      border: Border.all(color: border ?? AppColors.steel, width: 1),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.45),
          blurRadius: 24,
          offset: const Offset(0, 12),
        ),
      ],
    );
  }

  /// Glow used to make accent elements feel "live".
  static List<BoxShadow> glow(Color color, {double blur = 24}) => [
        BoxShadow(
          color: color.withOpacity(0.45),
          blurRadius: blur,
          spreadRadius: -4,
        ),
      ];
}
