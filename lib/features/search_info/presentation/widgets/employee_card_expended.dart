import 'package:flutter/material.dart';
import '../../../../core/constant/colors.dart';

class ExpandableSkills extends StatefulWidget {
  final List<String> skills;
  final int initialCount;

  const ExpandableSkills({
    super.key,
    required this.skills,
    this.initialCount = 2,
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

    final remainingCount = widget.skills.length - widget.initialCount;

    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        /// Skill chips
        ...visibleSkills.map((skill) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.kBorderColor),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(skill, style: const TextStyle(fontSize: 12)),
          );
        }),

        /// +count circle
        if (!expanded && remainingCount > 0)
          GestureDetector(
            onTap: () {
              setState(() {
                expanded = true;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.kBorderColor),
              ),
              child: Text(
                "+$remainingCount",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

        /// Show less
        if (expanded && widget.skills.length > widget.initialCount)
          GestureDetector(
            onTap: () {
              setState(() {
                expanded = false;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.kBorderColor),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text("Show Less", style: TextStyle(fontSize: 12)),
            ),
          ),
      ],
    );
  }
}
