import 'package:flutter/material.dart';
import '../core/constants/colors.dart';
import '../core/theme/typography.dart';

/// ReCyclo Global Theme Configuration
/// Enforces exact brand identity and Material 3 standards.
class ReCycloTheme {
  ReCycloTheme._();

  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.light(
      primary: ReCycloColors.primary,
      onPrimary: Colors.white,
      primaryContainer: ReCycloColors.primaryLight,
      onPrimaryContainer: ReCycloColors.primaryActive,
      secondary: ReCycloColors.brandDark,
      onSecondary: Colors.white,
      surface: Colors.white,
      onSurface: ReCycloColors.textPrimary,
      error: ReCycloColors.danger,
      onError: Colors.white,
      outline: ReCycloColors.border,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: ReCycloColors.bgApp,
      fontFamily: ReCycloTypography.bodyFont,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: ReCycloColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 1,
        centerTitle: true,
        titleTextStyle: ReCycloTypography.headingMedium,
        iconTheme: const IconThemeData(color: ReCycloColors.textPrimary),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: ReCycloColors.border, width: 1.0),
        ),
        margin: EdgeInsets.zero,
      ),
      dividerTheme: const DividerThemeData(
        color: ReCycloColors.divider,
        thickness: 1,
        space: 1,
      ),
    );
  }
}
