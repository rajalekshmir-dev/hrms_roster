import 'package:flutter/material.dart';

class SmallSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final String hint;

  const SmallSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    this.hint = "Search skill or designation",
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      height: 38,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),

      decoration: BoxDecoration(
        color: theme.colorScheme.surface,

        borderRadius: BorderRadius.circular(8),

        border: Border.all(
          color: theme.colorScheme.onSurface.withOpacity(0.15),
        ),

        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.4)
                : Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),

      child: Row(
        children: [
          Icon(
            Icons.search,
            size: 18,
            color: theme.colorScheme.onSurface.withOpacity(0.6),
          ),

          const SizedBox(width: 8),

          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,

              style: TextStyle(
                fontSize: 13,
                color: theme.colorScheme.onSurface,
              ),

              cursorColor: theme.colorScheme.primary,

              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  color: theme.colorScheme.onSurface.withOpacity(0.5),
                  fontSize: 13,
                ),

                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,

                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
