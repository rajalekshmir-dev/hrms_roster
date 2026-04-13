import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/search_bloc.dart';
import '../bloc/search_event.dart';

class HRMSSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onSearch;

  const HRMSSearchBar({
    super.key,
    required this.controller,
    required this.onSearch,
  });

  @override
  State<HRMSSearchBar> createState() => _HRMSSearchBarState();
}

class _HRMSSearchBarState extends State<HRMSSearchBar>
    with SingleTickerProviderStateMixin {
  String hintText = "";
  final String fullText = "Ask me anything...";
  int index = 0;

  late AnimationController _borderController;
  late Animation<double> _borderAnimation;

  @override
  void initState() {
    super.initState();

    startTyping();

    _borderController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _borderAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _borderController, curve: Curves.easeInOut),
    );
  }

  void startTyping() async {
    while (index < fullText.length) {
      await Future.delayed(const Duration(milliseconds: 80));

      if (!mounted) return;

      setState(() {
        hintText += fullText[index];
        index++;
      });
    }
  }

  @override
  void dispose() {
    _borderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final primary = theme.colorScheme.primary;
    final surface = theme.colorScheme.surface;

    return AnimatedBuilder(
      animation: _borderAnimation,
      builder: (context, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),

          child: Container(
            height: 52,

            decoration: BoxDecoration(
              color: surface,

              borderRadius: BorderRadius.circular(30),

              /// 🌗 Animated border glow
              border: Border.all(
                color: primary.withOpacity(_borderAnimation.value * 0.6),
                width: 1.5,
              ),

              /// 🌗 Adaptive shadow
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.black.withOpacity(0.4)
                      : primary.withOpacity(_borderAnimation.value * 0.2),
                  blurRadius: 12,
                  spreadRadius: 1,
                ),
              ],
            ),

            child: Row(
              children: [
                const SizedBox(width: 16),

                Icon(
                  Icons.search,
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),

                const SizedBox(width: 8),

                /// TEXT FIELD
                Expanded(
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      TextField(
                        controller: widget.controller,

                        style: TextStyle(color: theme.colorScheme.onSurface),

                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          isCollapsed: true,
                          contentPadding: EdgeInsets.zero,
                        ),

                        cursorColor: theme.colorScheme.primary,
                      ),

                      /// 👇 Animated hint overlay
                      IgnorePointer(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: widget.controller.text.isEmpty
                              ? Text(
                                  hintText,
                                  key: ValueKey(hintText),
                                  style: TextStyle(
                                    color: theme.colorScheme.onSurface
                                        .withOpacity(0.5),
                                    fontSize: 14,
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),
                      ),
                    ],
                  ),
                ),

                /// SEARCH BUTTON
                GestureDetector(
                  onTap: () {
                    context.read<EmployeeSearchBloc>().add(
                      SearchEmployeeEvent(query: widget.controller.text),
                    );
                  },

                  child: Container(
                    height: 52,
                    width: 60,

                    decoration: BoxDecoration(
                      color: primary,

                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),

                    child: const Icon(Icons.search, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
