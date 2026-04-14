import 'package:flutter/material.dart';

class HRMSBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const HRMSBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(left: 18, right: 18, bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),

      decoration: BoxDecoration(
        color: theme.colorScheme.surface,

        borderRadius: BorderRadius.circular(40),

        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.4)
                : Colors.black.withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _navItem(context, 0, Icons.home_outlined, Icons.home, "Home"),
          _navItem(context, 1, Icons.people_outline, Icons.people, "Users"),
          _navItem(
            context,
            2,
            Icons.insert_chart_outlined,
            Icons.insert_chart,
            "Schedule",
          ),
        ],
      ),
    );
  }

  Widget _navItem(
    BuildContext context,
    int index,
    IconData icon,
    IconData activeIcon,
    String label,
  ) {
    final isActive = currentIndex == index;
    final theme = Theme.of(context);

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,

          padding: const EdgeInsets.symmetric(vertical: 8),

          decoration: BoxDecoration(
            color: isActive
                ? theme.colorScheme.primary.withOpacity(0.12)
                : Colors.transparent,

            borderRadius: BorderRadius.circular(30),
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedScale(
                duration: const Duration(milliseconds: 200),
                scale: isActive ? 1.15 : 1.0,
                child: Icon(
                  isActive ? activeIcon : icon,
                  size: 24,
                  color: isActive
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),

              const SizedBox(height: 3),

              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                  color: isActive
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurface.withOpacity(0.6),
                ),
                child: Text(label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
