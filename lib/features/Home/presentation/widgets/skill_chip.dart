import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrms_roster/core/constant/colors.dart';
import 'package:hrms_roster/core/constant/text_style.dart';

class SkillChip extends StatelessWidget {
  final String skill;
  final VoidCallback? onTap;
  final bool isRemovable;
  final VoidCallback? onRemove;

  const SkillChip({
    super.key,
    required this.skill,
    this.onTap,
    this.isRemovable = false,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.kSoftColor,
              AppColors.kSoftColor.withOpacity(0.5),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.kPrimaryColor.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                skill,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.kPrimaryColor,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.visible,
                softWrap: true,
              ),
            ),
            if (isRemovable && onRemove != null) ...[
              const SizedBox(width: 4),
              GestureDetector(
                onTap: onRemove,
                child: Icon(
                  Icons.close,
                  size: 14,
                  color: AppColors.kPrimaryColor,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
