import 'package:flutter/material.dart';

class HRMSSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;

  const HRMSSearchBar({
    super.key,
    required this.controller,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    late FocusNode _focusNode;
    bool _isLoading = false;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: const Color(0xFF4C6EDB), width: 1.2),
        ),
        child: Row(
          children: [
            /// left search icon
            const SizedBox(width: 16),
            const Icon(Icons.search, color: Colors.grey),

            const SizedBox(width: 8),

            /// text field
            Expanded(
              child: TextField(
                // controller: widget.controller,
                // focusNode: _focusNode,
                decoration: const InputDecoration(
                  hintText: "freepool in kochi",
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),

            /// search button
            GestureDetector(
              onTap: onSearch,
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
  }
}
