import 'package:flutter/material.dart';
import '../constant/colors.dart';
import '../constant/text_style.dart';

class CommonInfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isClickable;
  final VoidCallback? onTap;
  final double labelWidth;

  const CommonInfoRow({
    super.key,
    required this.label,
    required this.value,
    this.isClickable = false,
    this.onTap,
    this.labelWidth = 130,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: labelWidth,
            child: Text(
              label,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.kLightTextColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: isClickable && onTap != null
                ? GestureDetector(
                    onTap: onTap,
                    child: Text(
                      value,
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.kPrimaryColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                : Text(
                    value,
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.kHeadingColor,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
