import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Typography for LeadershipOS.
/// - Display / headings: Sora (geometric, authoritative)
/// - Body / UI: Manrope (clean, legible)
/// - Data / numbers / meters: JetBrains Mono (terminal feel)
class AppType {
  AppType._();

  static TextStyle display(double size,
      {FontWeight weight = FontWeight.w700, Color? color, double? height}) {
    return GoogleFonts.sora(
      fontSize: size,
      fontWeight: weight,
      height: height,
      letterSpacing: -0.5,
      color: color ?? AppColors.platinum,
    );
  }

  static TextStyle body(double size,
      {FontWeight weight = FontWeight.w500, Color? color, double? height}) {
    return GoogleFonts.manrope(
      fontSize: size,
      fontWeight: weight,
      height: height ?? 1.4,
      color: color ?? AppColors.silver,
    );
  }

  static TextStyle mono(double size,
      {FontWeight weight = FontWeight.w600, Color? color, double? spacing}) {
    return GoogleFonts.jetBrainsMono(
      fontSize: size,
      fontWeight: weight,
      letterSpacing: spacing ?? 0.5,
      color: color ?? AppColors.platinum,
    );
  }

  /// Uppercase tracked label used for section headers / status chips.
  static TextStyle label(double size, {Color? color}) {
    return GoogleFonts.manrope(
      fontSize: size,
      fontWeight: FontWeight.w700,
      letterSpacing: 2.0,
      color: color ?? AppColors.textMuted,
    );
  }
}
