import 'package:flutter/material.dart';

import '../../../../core/widgets/common_card.dart';

class UserInfoCard extends StatelessWidget {
  final String name;
  final String id;
  final String designation;
  final String skills;

  const UserInfoCard({
    super.key,
    required this.name,
    required this.id,
    required this.designation,
    required this.skills,
  });

  @override
  Widget build(BuildContext context) {
    return CommonAnimatedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// NAME
          Text(
            name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 6),

          /// ID
          Text("ID : $id", style: TextStyle(color: Colors.grey.shade600)),

          const SizedBox(height: 6),

          /// DESIGNATION
          Text(
            designation,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),

          const SizedBox(height: 10),

          /// SKILLS
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: skills.split(",").map((skill) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  skill.trim(),
                  style: TextStyle(fontSize: 12, color: Colors.blue.shade700),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
