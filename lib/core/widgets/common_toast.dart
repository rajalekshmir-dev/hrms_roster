import 'package:flutter/material.dart';
import '../constant/colors.dart';
import '../constant/text_style.dart';

enum ToastType { success, error, info, warning }

class CommonToast {
  // Show success message
  static void showSuccess(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    _showSnackBar(
      context,
      message: message,
      type: ToastType.success,
      duration: duration,
    );
  }

  // Show error message
  static void showError(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    _showSnackBar(
      context,
      message: message,
      type: ToastType.error,
      duration: duration,
    );
  }

  // Show info message
  static void showInfo(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    _showSnackBar(
      context,
      message: message,
      type: ToastType.info,
      duration: duration,
    );
  }

  // Show warning message
  static void showWarning(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    _showSnackBar(
      context,
      message: message,
      type: ToastType.warning,
      duration: duration,
    );
  }

  // Generic method to show snackbar
  static void _showSnackBar(
    BuildContext context, {
    required String message,
    required ToastType type,
    required Duration duration,
  }) {
    // Get colors based on type
    final colorScheme = _getColorScheme(type);

    // Dismiss any existing snackbar
    ScaffoldMessenger.of(context).clearSnackBars();

    // Show new snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CommonToastContent(
          message: message,
          type: type,
          icon: colorScheme.icon,
        ),
        backgroundColor: colorScheme.backgroundColor,
        behavior: SnackBarBehavior.floating,
        duration: duration,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        padding: EdgeInsets.zero,
        elevation: 4,
      ),
    );
  }

  // Get color scheme based on toast type
  static _ToastColorScheme _getColorScheme(ToastType type) {
    switch (type) {
      case ToastType.success:
        return _ToastColorScheme(
          backgroundColor: AppColors.success,
          icon: Icons.check_circle_outline,
        );
      case ToastType.error:
        return _ToastColorScheme(
          backgroundColor: AppColors.error,
          icon: Icons.error_outline,
        );
      case ToastType.info:
        return _ToastColorScheme(
          backgroundColor: AppColors.kPrimaryColor,
          icon: Icons.info_outline,
        );
      case ToastType.warning:
        return _ToastColorScheme(
          backgroundColor: AppColors.kStatusInProgress,
          icon: Icons.warning_amber_outlined,
        );
    }
  }
}

// Helper class for color scheme
class _ToastColorScheme {
  final Color backgroundColor;
  final IconData icon;

  _ToastColorScheme({required this.backgroundColor, required this.icon});
}

// Toast Content Widget
class CommonToastContent extends StatelessWidget {
  final String message;
  final ToastType type;
  final IconData icon;

  const CommonToastContent({
    super.key,
    required this.message,
    required this.type,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: AppTextStyles.body.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (type != ToastType.info)
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
              child: const Icon(Icons.close, color: Colors.white, size: 18),
            ),
        ],
      ),
    );
  }
}
