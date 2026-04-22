import 'package:flutter/material.dart';
import 'package:hrms_roster/core/widgets/common_card.dart';

class RequirementCard extends StatelessWidget {
  final String project;
  final String client;
  final String requirement;
  final String updatedAt;
  final IconData icon;
  final Color color;

  const RequirementCard({
    super.key,
    required this.project,
    required this.client,
    required this.requirement,
    required this.updatedAt,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CommonAnimatedCard(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: SizedBox(
        height: 90, // 👈 fixed height like web rows
        child: Row(
          children: [
            /// Icon
            Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: color.withOpacity(.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 22),
            ),

            const SizedBox(width: 12),

            /// Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// Project
                  Text(
                    project,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 4),

                  /// Client
                  Text(
                    client,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),

                  const SizedBox(height: 6),

                  /// Requirement
                  Text(
                    requirement,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13),
                  ),

                  /// Requirement
                  Text(
                    updatedAt,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),

            /// Menu
            const Icon(Icons.more_vert, size: 20),
          ],
        ),
      ),
    );
  }
}
