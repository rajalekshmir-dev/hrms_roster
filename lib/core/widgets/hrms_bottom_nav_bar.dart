import 'package:flutter/material.dart';
import 'package:hrms_roster/core/constant/colors.dart';

class HRMSBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const HRMSBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<HRMSBottomNavBar> createState() => _HRMSBottomNavBarState();
}

class _HRMSBottomNavBarState extends State<HRMSBottomNavBar>
    with SingleTickerProviderStateMixin {
  final List<_NavItem> items = const [
    _NavItem(Icons.home_outlined, Icons.home, "Home"),
    _NavItem(Icons.people_outline, Icons.people, "Users"),
    _NavItem(Icons.insert_chart_outlined, Icons.insert_chart, "Schedule"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(items.length, (index) {
          final isSelected = widget.currentIndex == index;
          final item = items[index];

          return Expanded(
            child: GestureDetector(
              onTap: () => widget.onTap(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeOutCubic,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.kPrimaryColor.withOpacity(0.12)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedScale(
                      duration: const Duration(milliseconds: 250),
                      scale: isSelected ? 1.2 : 1.0,
                      child: Icon(
                        isSelected ? item.activeIcon : item.icon,
                        color: isSelected
                            ? AppColors.kPrimaryColor
                            : Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 250),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w400,
                        color: isSelected
                            ? AppColors.kPrimaryColor
                            : Colors.grey.shade600,
                      ),
                      child: Text(item.label),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const _NavItem(this.icon, this.activeIcon, this.label);
}
