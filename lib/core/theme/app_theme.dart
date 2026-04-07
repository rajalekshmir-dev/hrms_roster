import 'package:flutter/material.dart';
import '../constant/colors.dart';

class AppTheme {
  const AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,

    /// PRIMARY COLORS
    primaryColor: AppColors.kPrimaryColor,
    scaffoldBackgroundColor: AppColors.kDashboardBgColor,

    colorScheme: const ColorScheme.light().copyWith(
      primary: AppColors.kPrimaryColor,
      secondary: AppColors.kSoftColor,
      surface: AppColors.kBackgroundLightColor,
    ),

    /// APP BAR
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.kPrimaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
    ),

    /// TEXT THEME
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: AppColors.kLightTextColor, fontSize: 14),
      bodySmall: TextStyle(color: AppColors.kLightTextColor, fontSize: 12),
      titleMedium: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: AppColors.kLightTextColor,
      ),
    ),

    /// CARD STYLE
    cardTheme: const CardThemeData(
      color: Colors.white,
      elevation: 0,
      margin: EdgeInsets.zero,
    ),

    /// DIVIDER
    dividerTheme: const DividerThemeData(color: Colors.black12, thickness: 1),

    /// TEXT BUTTON
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: AppColors.kHoverColor),
    ),

    /// INPUT FIELD (Search bars, forms)
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: const BorderSide(color: AppColors.kHoverSecondaryColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: const BorderSide(color: AppColors.kHoverSecondaryColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: const BorderSide(
          color: AppColors.kPrimaryColor,
          width: 1.5,
        ),
      ),
    ),
  );
}
