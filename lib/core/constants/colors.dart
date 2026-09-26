import 'package:flutter/material.dart';

/// ReCyclo Official Brand Colors
/// Strict single source of truth extracted from the official ReCyclo logo & identity.
class ReCycloColors {
  ReCycloColors._();

  // Core Primary Colors
  static const Color primary = Color(0xFF00A884); // Signature Emerald Teal
  static const Color primaryHover = Color(0xFF008F70);
  static const Color primaryActive = Color(0xFF00765C);
  static const Color primaryLight = Color(0xFFE6F7F2); // Mint Tint
  static const Color primarySurface = Color(0xFFF0FAF7); // Soft surface
  static const Color primaryGlow = Color(0x3800A884);

  // Deep Brand Teals (from Logo "Re" & ribbon)
  static const Color brandDark = Color(0xFF034158); // Deep Marine Teal
  static const Color brandNavy = Color(0xFF022C3A); // Deepest Brand Navy
  static const Color brandDarkSurface = Color(0xFF062833);

  // Logo Gradient Accents
  static const Color accentLeaf = Color(0xFF24BD84); // Luminous Leaf Green
  static const Color accentCyan = Color(0xFF00A5A1); // Turquoise Ribbon Accent
  static const Color accentMint = Color(0xFF4ADE80);

  // Semantic Feedback
  static const Color success = Color(0xFF00A884);
  static const Color successBg = Color(0xFFE6F7F2);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningBg = Color(0xFFFEF3C7);
  static const Color danger = Color(0xFFEF4444);
  static const Color dangerBg = Color(0xFFFEE2E2);
  static const Color info = Color(0xFF0284C7);
  static const Color infoBg = Color(0xFFE0F2FE);

  // Availability Badges
  static const Color badgeAvailableText = Color(0xFF047857);
  static const Color badgeAvailableBg = Color(0xFFD1FAE5);
  static const Color badgeBusyText = Color(0xFFB45309);
  static const Color badgeBusyBg = Color(0xFFFEF3C7);
  static const Color badgeOfflineText = Color(0xFF475569);
  static const Color badgeOfflineBg = Color(0xFFF1F5F9);

  // Neutrals & Typography
  static const Color textPrimary = Color(0xFF0A242B); // Charcoal Teal
  static const Color textSecondary = Color(0xFF4B646D); // Slate Teal
  static const Color textMuted = Color(0xFF7E97A0); // Soft Muted
  static const Color textInverse = Color(0xFFFFFFFF);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Surfaces & Backgrounds
  static const Color bgApp = Color(0xFFF3F7F7);
  static const Color bgCard = Color(0xFFFFFFFF);
  static const Color bgCardElevated = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFE0ECE9);
  static const Color borderSubtle = Color(0xFFEEF5F3);
  static const Color borderFocus = Color(0xFF00A884);
  static const Color divider = Color(0xFFE8F1EF);
}
