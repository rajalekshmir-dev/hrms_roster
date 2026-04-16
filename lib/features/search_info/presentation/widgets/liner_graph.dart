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

    // Low Skill (Red)
    if (score < 40) {
      return const [Color(0xff871f1f), Color(0xffa83636)];
    }

    // Medium Skill (Orange)
    if (score < 70) {
      return const [Color(0xffce6d07), Color(0xfff08a1c)];
    }

    // High Skill (Green)
    return const [Color(0xff0a5d0a), Color(0xff1e8a1e)];
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
    value = value.clamp(0, 100);

    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth * (value / 100);

          return Stack(
            children: [
              /// Background track
              Container(
                height: 14,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),

              /// Filled gradient
              AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                width: width,
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
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
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
