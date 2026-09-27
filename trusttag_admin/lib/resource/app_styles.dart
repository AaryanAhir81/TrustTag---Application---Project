import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_sizes.dart';

class AppStyles {
  AppStyles._();

  // Typography
  static const TextStyle brandText = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle headingLarge = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.25,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static const TextStyle label = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle link = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w600,
    color: AppColors.link,
  );

  static const TextStyle body = TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static const TextStyle button = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    color: AppColors.textLight,
  );

  static const TextStyle footer = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted,
  );

  // Input Field Decoration
  static InputDecoration inputDecoration({
    required String hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(
        fontSize: 13.0,
        color: AppColors.textMuted,
        fontWeight: FontWeight.w400,
      ),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: AppColors.inputBackground,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSizes.md,
        vertical: AppSizes.sm + 4,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        borderSide: const BorderSide(color: AppColors.inputBorder, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        borderSide: const BorderSide(color: AppColors.inputFocusedBorder, width: 1.5),
      ),
    );
  }
}
