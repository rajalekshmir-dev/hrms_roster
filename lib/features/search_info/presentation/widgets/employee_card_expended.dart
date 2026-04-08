import 'package:flutter/material.dart';

import '../../../../core/constant/colors.dart';

class ExpandableSkills extends StatefulWidget {
  final List<String> skills;
  final int initialCount;

  const ExpandableSkills({
    super.key,
    required this.skills,
    this.initialCount = 6,
  });

  @override
  State<ExpandableSkills> createState() => _ExpandableSkillsState();
}

class _ExpandableSkillsState extends State<ExpandableSkills> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final visibleSkills = expanded
        ? widget.skills
        : widget.skills.take(widget.initialCount).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Skills chips
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: visibleSkills.map((skill) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.kBorderColor),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(skill, style: const TextStyle(fontSize: 12)),
            );
          }).toList(),
        ),

        /// Show More / Show Less
        if (widget.skills.length > widget.initialCount)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  expanded = !expanded;
                });
              },
              child: Text(
                expanded ? "Show Less" : "Show More",
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
