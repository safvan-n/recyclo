import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';

/// ReCyclo Official Typography System
/// Primary Display: Outfit
/// Primary Body / Interface: Plus Jakarta Sans
class ReCycloTypography {
  ReCycloTypography._();

  // Font Families
  static String get displayFont => GoogleFonts.outfit().fontFamily ?? 'Outfit';
  static String get bodyFont => GoogleFonts.plusJakartaSans().fontFamily ?? 'Plus Jakarta Sans';

  // Text Styles
  static TextStyle displayLarge = GoogleFonts.outfit(
    fontSize: 28,
    fontWeight: FontWeight.w800,
    color: ReCycloColors.textPrimary,
    letterSpacing: -0.5,
  );

  static TextStyle displayMedium = GoogleFonts.outfit(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: ReCycloColors.textPrimary,
    letterSpacing: -0.3,
  );

  static TextStyle headingLarge = GoogleFonts.outfit(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: ReCycloColors.textPrimary,
    letterSpacing: -0.2,
  );

  static TextStyle headingMedium = GoogleFonts.plusJakartaSans(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: ReCycloColors.textPrimary,
  );

  static TextStyle titleMedium = GoogleFonts.plusJakartaSans(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: ReCycloColors.textPrimary,
  );

  static TextStyle bodyLarge = GoogleFonts.plusJakartaSans(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: ReCycloColors.textPrimary,
    height: 1.45,
  );

  static TextStyle bodyMedium = GoogleFonts.plusJakartaSans(
    fontSize: 13.5,
    fontWeight: FontWeight.w400,
    color: ReCycloColors.textSecondary,
    height: 1.4,
  );

  static TextStyle bodySmall = GoogleFonts.plusJakartaSans(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: ReCycloColors.textMuted,
  );

  static TextStyle labelLarge = GoogleFonts.plusJakartaSans(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: ReCycloColors.textPrimary,
  );

  static TextStyle labelSmall = GoogleFonts.plusJakartaSans(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
  );
}
