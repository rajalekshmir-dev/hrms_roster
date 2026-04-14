import 'package:flutter/material.dart';

class MatchOverviewGraph extends StatelessWidget {
  final int skill;
  final int experience;
  final int availability;

  const MatchOverviewGraph({
    super.key,
    required this.skill,
    required this.experience,
    required this.availability,
  });

  List<Color> getGradient(int score) {
    score = score.clamp(0, 100);

    if (score <= 50) {
      final t = score / 50;
      return [
        Color.lerp(const Color(0xffef4444), const Color(0xfff59e0b), t)!,
        Color.lerp(const Color(0xfff87171), const Color(0xfffbbf24), t)!,
      ];
    }

    final t = (score - 50) / 50;
    return [
      Color.lerp(const Color(0xfff59e0b), const Color(0xff16a34a), t)!,
      Color.lerp(const Color(0xfffbbf24), const Color(0xff4ade80), t)!,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Match Overview",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),

        const SizedBox(height: 12),

        /// SEGMENT GRAPH
        Row(
          children: [
            _segment(skill, getGradient(skill)),
            const SizedBox(width: 6),

            _segment(experience, getGradient(experience)),
            const SizedBox(width: 6),

            _segment(availability, getGradient(availability)),
          ],
        ),

        const SizedBox(height: 10),

        /// LEGEND
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _legend("Skill", skill),
            _legend("Experience", experience),
            _legend("Availability", availability),
          ],
        ),
      ],
    );
  }

  Widget _segment(int value, List<Color> gradient) {
    return Expanded(
      child: Container(
        height: 14,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: gradient,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [
            BoxShadow(
              color: gradient.last.withOpacity(.35),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _legend(String label, int score) {
    final colors = getGradient(score);

    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: colors),
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 5),
        Text(
          "$label $score%",
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
