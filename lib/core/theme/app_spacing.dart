import 'package:flutter/material.dart';

/// Spacing scale (8pt-based) and shared shape tokens.
class AppSpace {
  AppSpace._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;

  static const double screenPad = 20;

  // Radii
  static const double rSm = 10;
  static const double rMd = 16;
  static const double rLg = 22;
  static const double rPill = 100;

  static BorderRadius radius(double r) => BorderRadius.circular(r);
}
