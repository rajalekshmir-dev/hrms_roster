import 'package:flutter/material.dart';

class CommonAnimatedCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Duration duration;

  const CommonAnimatedCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedContainer(
      duration: duration,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),

        /// 🌗 Background changes with theme
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,

        /// 🌗 Border adapts
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.08)
              : Colors.blue.withOpacity(0.08),
          width: 1,
        ),

        /// 🌗 Shadow adapts
        boxShadow: isDark
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 25,
                  spreadRadius: 2,
                  offset: const Offset(0, 12),
                ),
                BoxShadow(
                  color: Colors.blue.withOpacity(0.08),
                  blurRadius: 20,
                  spreadRadius: -4,
                  offset: const Offset(0, 6),
                ),
              ],
      ),
      child: child,
    );
  }
}
