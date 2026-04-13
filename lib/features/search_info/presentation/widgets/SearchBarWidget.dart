import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms_roster/features/search_info/presentation/bloc/search_bloc.dart';

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

    /// border animation
    _borderController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _borderAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
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
    return AnimatedBuilder(
      animation: _borderAnimation,
      builder: (context, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Container(
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: const Color(
                  0xFF4C6EDB,
                ).withOpacity(_borderAnimation.value),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(
                    0xFF4C6EDB,
                  ).withOpacity(_borderAnimation.value * 0.4),
                  blurRadius: 12,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Row(
              children: [
                const SizedBox(width: 16),
                const Icon(Icons.search, color: Colors.grey),
                const SizedBox(width: 8),

                /// TextField
                Expanded(
                  child: TextField(
                    controller: widget.controller,
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      isCollapsed: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    onSubmitted: (value) {
                      context.read<EmployeeSearchBloc>().add(
                        SearchEmployeeEvent(query: value),
                      );
                    },
                  ),
                ),

                /// search button
                GestureDetector(
                  onTap: () {
                    context.read<EmployeeSearchBloc>().add(
                      SearchEmployeeEvent(query: widget.controller.text),
                    );
                  },
                  child: Container(
                    height: 52,
                    width: 60,
                    decoration: const BoxDecoration(
                      color: Color(0xFF2E4DA7),
                      borderRadius: BorderRadius.only(
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
