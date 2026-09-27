import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_sizes.dart';

class AppThemes {
  AppThemes._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: 'Segoe UI',
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        surface: AppColors.surface,
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusLg),
          side: const BorderSide(color: AppColors.cardBorder, width: 1.0),
        ),
      ),
    );
  }
}
