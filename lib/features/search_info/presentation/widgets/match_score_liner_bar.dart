import 'package:flutter/material.dart';

class MatchScoreBar extends StatelessWidget {
  final String label;
  final int score;

  const MatchScoreBar({super.key, required this.label, required this.score});

  Color getColor(int score) {
    if (score >= 90) return Colors.green;
    if (score >= 70) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(label), Text("$score%")],
        ),

        const SizedBox(height: 6),

        TweenAnimationBuilder(
          duration: const Duration(milliseconds: 800),
          tween: Tween(begin: 0.0, end: score / 100),
          builder: (context, value, child) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: value,
                minHeight: 8,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation(getColor(score)),
              ),
            );
          },
        ),
      ],
    );
  }
}
