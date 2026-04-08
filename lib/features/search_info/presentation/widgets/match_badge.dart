import 'package:flutter/material.dart';

class MatchBadge extends StatelessWidget {
  final int match;

  const MatchBadge({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Main badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xff22c55e), Color(0xff16a34a)],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.2),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Text(
            "$match% Match",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),

        /// small pointer
      ],
    );
  }
}
