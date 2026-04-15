import 'package:alabtechnology/core/theme/font_size.dart';
import 'package:flutter/material.dart';

abstract final class AppTextTheme {
  static TextTheme textTheme(
      [Color primaryText = const Color(0xFF1A1A1A),
      Color secondaryText = const Color(0xFF6B6B6B),]) {
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: AppFontSize.xxl,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        color: primaryText,
      ),
      displayMedium: TextStyle(
        fontSize: AppFontSize.xl,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.25,
        color: primaryText,
      ),
      displaySmall: TextStyle(
        fontSize: AppFontSize.lg,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        color: primaryText,
      ),
      headlineLarge: TextStyle(
        fontSize: AppFontSize.xxl,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.25,
        color: primaryText,
      ),
      headlineMedium: TextStyle(
        fontSize: AppFontSize.lg,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        color: primaryText,
      ),
      headlineSmall: TextStyle(
        fontSize: AppFontSize.md,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        color: primaryText,
      ),
      titleLarge: TextStyle(
        fontSize: AppFontSize.md,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        color: primaryText,
      ),
      titleMedium: TextStyle(
        fontSize: AppFontSize.sm,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        color: primaryText,
      ),
      titleSmall: TextStyle(
        fontSize: AppFontSize.xs,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        color: primaryText,
      ),
      bodyLarge: TextStyle(
        fontSize: AppFontSize.sm,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        color: primaryText,
      ),
      bodyMedium: TextStyle(
        fontSize: AppFontSize.xs,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: primaryText,
      ),
      bodySmall: TextStyle(
        fontSize: AppFontSize.xxs,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: secondaryText,
      ),
      labelLarge: TextStyle(
        fontSize: AppFontSize.xs,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        color: primaryText,
      ),
      labelMedium: TextStyle(
        fontSize: AppFontSize.xxs,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: secondaryText,
      ),
      labelSmall: TextStyle(
        fontSize: AppFontSize.xxs,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: secondaryText,
      ),
    );
  }
}
