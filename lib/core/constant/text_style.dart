import 'package:flutter/material.dart';

import 'colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const String fontFamily = "Inter";

  /// Main Page Titles
  static const TextStyle headline = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.kHeadingColor,
    letterSpacing: 0.3,
  );

  /// Section Titles
  static const TextStyle sectionTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.kHeadingColor,
  );

  /// Card Title / Employee Name
  static const TextStyle title = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.kHeadingColor,
  );

  /// Sub text
  static const TextStyle subtitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.kLightTextColor,
  );

  /// Main body text
  static const TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.kAssistantTextPrimary,
    height: 1.4,
  );

  /// Small secondary text
  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.kAssistantTextSecondary,
  );

  /// Badge text
  static const TextStyle badge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: AppColors.kDarkTextColor,
    letterSpacing: 0.2,
  );

  /// Button text
  static const TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}
