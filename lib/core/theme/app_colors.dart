import 'package:flutter/material.dart';

/// Central color system for LeadershipOS.
/// Aesthetic: black void + deep institutional blue + cold silver,
/// with a single electric accent used sparingly for "live" / high-status moments.
class AppColors {
  AppColors._();

  // ── Surfaces (near-black, layered for depth) ──────────────────────────
  static const Color voidBlack = Color(0xFF05070B); // app background
  static const Color obsidian = Color(0xFF0A0E16); // base surface
  static const Color carbon = Color(0xFF111723); // raised card
  static const Color slate = Color(0xFF1A2233); // elevated / hover
  static const Color steel = Color(0xFF26314A); // borders / dividers

  // ── Brand blues ───────────────────────────────────────────────────────
  static const Color deepBlue = Color(0xFF0B2A4A);
  static const Color royalBlue = Color(0xFF1E5BB8);
  static const Color electric = Color(0xFF2F8BFF); // primary accent
  static const Color glowBlue = Color(0xFF5AB0FF); // highlights / glow

  // ── Silver / text ─────────────────────────────────────────────────────
  static const Color silver = Color(0xFFC7D0DE);
  static const Color platinum = Color(0xFFEAF0F8); // primary text
  static const Color textMuted = Color(0xFF8A95AB); // secondary text
  static const Color textFaint = Color(0xFF53607A); // captions / hints

  // ── Signal colors (scores, meters, status) ────────────────────────────
  static const Color success = Color(0xFF34D399); // green
  static const Color warning = Color(0xFFFBBF24); // amber
  static const Color danger = Color(0xFFFB5E5E); // red / high pressure
  static const Color gold = Color(0xFFE7C063); // achievements / level

  // ── Gradients ─────────────────────────────────────────────────────────
  static const LinearGradient accentGradient = LinearGradient(
    colors: [royalBlue, electric],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient surfaceGradient = LinearGradient(
    colors: [carbon, obsidian],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const RadialGradient spotlight = RadialGradient(
    colors: [Color(0x332F8BFF), Color(0x00000000)],
    radius: 0.9,
  );

  /// Maps a 0–100 intensity value to a meter color (green → amber → red).
  static Color intensity(double value) {
    if (value < 40) return success;
    if (value < 70) return warning;
    return danger;
  }
}
