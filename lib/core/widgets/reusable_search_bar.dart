import 'package:flutter/material.dart';
import 'package:hrms_roster/core/constant/text_style.dart';
import '../constant/colors.dart';

class ReusableSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback? onFilterTap;
  final ValueChanged<String>? onSearchChanged;
  final VoidCallback? onClearTap;
  final bool showFilterButton;

  const ReusableSearchBar({
    super.key,
    required this.controller,
    this.hintText = 'Search...',
    this.onFilterTap,
    this.onSearchChanged,
    this.onClearTap,
    this.showFilterButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.kGreyColor),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          // Search Icon
          Icon(Icons.search, color: AppColors.kLightTextColor, size: 20),
          const SizedBox(width: 12),

          // Search Input
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: (value) {
                if (onSearchChanged != null) {
                  onSearchChanged!(value);
                }
              },
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: AppTextStyles.caption.copyWith(
                  color: AppColors.kLightTextColor,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 10,
                ),
              ),
              style: AppTextStyles.body.copyWith(fontSize: 14),
              autofocus: false,
            ),
          ),

          // Clear Button
          if (controller.text.isNotEmpty)
            GestureDetector(
              onTap: () {
                controller.clear();
                if (onClearTap != null) {
                  onClearTap!();
                }
                if (onSearchChanged != null) {
                  onSearchChanged!('');
                }
              },
              child: Container(
                padding: const EdgeInsets.all(4),
                child: Icon(
                  Icons.close,
                  size: 18,
                  color: AppColors.kLightTextColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
