import 'package:flutter/material.dart';
import '../constant/colors.dart';
import '../constant/text_style.dart';
import 'custom_divider.dart';

class CommonSectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;
  final VoidCallback? onTap;

  const CommonSectionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(icon, size: 20, color: AppColors.kPrimaryColor),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(title, style: AppTextStyles.sectionTitle),
                  ),
                  if (onTap != null)
                    Icon(Icons.chevron_right, color: AppColors.kLightTextColor),
                ],
              ),
            ),
          ),
          const CustomDivider(thickness: 1),
          Padding(padding: const EdgeInsets.all(16), child: child),
        ],
      ),
    );
  }
}
