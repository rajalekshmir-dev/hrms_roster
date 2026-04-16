import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrms_roster/core/constant/colors.dart';

class CustomDivider extends StatelessWidget {
  final double height;
  final double thickness;
  final double indent;
  final double endIndent;
  final Color? color;

  const CustomDivider({
    super.key,
    this.height = 1,
    this.thickness = 0.5,
    this.indent = 0,
    this.endIndent = 0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      thickness: thickness,
      indent: indent,
      endIndent: endIndent,
      color: color ?? AppColors.kDashboardBgColor,
    );
  }
}