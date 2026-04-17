import 'package:flutter/material.dart';
import '../constant/colors.dart';
import '../constant/text_style.dart';

class CommonErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const CommonErrorState({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: AppColors.error),
          const SizedBox(height: 16),
          Text(message, style: AppTextStyles.body, textAlign: TextAlign.center),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.kPrimaryColor,
              foregroundColor: AppColors.kSoftColor,
            ),
          ),
        ],
      ),
    );
  }
}
