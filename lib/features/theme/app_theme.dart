import 'package:flutter/material.dart';

import '../../core/constant/colors.dart';

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
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,

    /// PRIMARY COLORS
    primaryColor: AppColors.kPrimaryColor,
    scaffoldBackgroundColor: const Color(0xFF121212),

    colorScheme: const ColorScheme.dark().copyWith(
      primary: AppColors.kPrimaryColor,
      secondary: AppColors.kSoftColor,
      surface: Color(0xFF1E1E1E),
    ),

    /// APP BAR
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
    ),

    /// TEXT THEME
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.white70, fontSize: 14),
      bodySmall: TextStyle(color: Colors.white60, fontSize: 12),
      titleMedium: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: Colors.white,
      ),
    ),

    /// CARD STYLE
    cardTheme: const CardThemeData(
      color: Color(0xFF1E1E1E),
      elevation: 0,
      margin: EdgeInsets.zero,
    ),

    /// DIVIDER
    dividerTheme: const DividerThemeData(color: Colors.white24, thickness: 1),

    /// TEXT BUTTON
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: AppColors.kHoverColor),
    ),

    /// INPUT FIELD
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1E1E1E),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: const BorderSide(color: Colors.white24),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: const BorderSide(color: Colors.white24),
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
