// lib/core/widgets/reusable_sections.dart
import 'package:flutter/material.dart';
import 'package:hrms_roster/core/constant/colors.dart';

class LogoSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final String badgeText;

  const LogoSection({
    super.key,
    required this.title,
    required this.subtitle,
    this.badgeText = 'HRMS.AI',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.kPrimaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.auto_awesome,
                size: 16,
                color: AppColors.kPrimaryColor,
              ),
              const SizedBox(width: 6),
              Text(
                badgeText,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.kPrimaryColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF666666),
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

class WelcomeSection extends StatelessWidget {
  final String title;
  final String subtitle;

  const WelcomeSection({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF666666),
          ),
        ),
      ],
    );
  }
}

class FooterSection extends StatelessWidget {
  final String question;
  final String actionText;
  final VoidCallback onActionPressed;

  const FooterSection({
    super.key,
    required this.question,
    required this.actionText,
    required this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          const Divider(
            color: Color(0xFFE0E0E0),
            thickness: 1,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                question,
                style: const TextStyle(
                  color: Color(0xFF666666),
                  fontSize: 13,
                ),
              ),
              TextButton(
                onPressed: onActionPressed,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  actionText,
                  style: const TextStyle(
                    color: AppColors.kPrimaryColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}