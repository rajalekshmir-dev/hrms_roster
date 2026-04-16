import 'package:flutter/material.dart';

class MatchBadge extends StatelessWidget {
  final double match;

  const MatchBadge({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: ShapeDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xff22c55e), Color(0xff16a34a)],
            ),
            shape: const StadiumBorder(),
            shadows: [
              BoxShadow(
                color: Colors.black.withOpacity(.2),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Text(
            "${match.round()}% Match",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
