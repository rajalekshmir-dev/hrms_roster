import 'package:flutter/material.dart';

import '../../data/models/search_info_model.dart';
import 'employee_card_expended.dart';
import 'match_badge.dart';
import 'match_score_liner_bar.dart';

class EmployeeCard extends StatefulWidget {
  final EmployeeModel employee;

  const EmployeeCard({super.key, required this.employee});

  @override
  State<EmployeeCard> createState() => _EmployeeCardState();
}

class _EmployeeCardState extends State<EmployeeCard>
    with TickerProviderStateMixin {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final employee = widget.employee;

    return GestureDetector(
      onTap: () {
        setState(() {
          expanded = !expanded;
        });
      },

      child: RepaintBoundary(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
            color: Colors.white,
          ),

          child: Stack(
            clipBehavior: Clip.none,
            children: [
              /// CARD CONTENT
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Name
                  Text(
                    employee.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    employee.designation,
                    style: const TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 10),

                  /// Details
                  Wrap(
                    spacing: 16,
                    runSpacing: 6,
                    children: [
                      _info(Icons.badge, employee.id),
                      _info(Icons.business, employee.department),
                      _info(Icons.location_on, employee.location),
                      _info(Icons.code, employee.techGroup),
                      _info(Icons.timeline, employee.totalExp),
                    ],
                  ),

                  const SizedBox(height: 10),

                  /// Project
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      "${employee.projectName} - ${employee.occupancy}%",
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// Skills
                  const Text(
                    "Skills:",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),

                  const SizedBox(height: 6),

                  ExpandableSkills(skills: employee.skills),

                  /// EXPANDED CONTENT
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: expanded
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 14),

                              const Divider(),

                              const SizedBox(height: 10),

                              /// Availability
                              const Text(
                                "Availability",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),

                              const SizedBox(height: 8),

                              const MatchScoreBar(
                                label: "Skill Match",
                                score: 90,
                              ),

                              const SizedBox(height: 8),

                              const MatchScoreBar(
                                label: "Experience Match",
                                score: 80,
                              ),

                              const SizedBox(height: 8),

                              const MatchScoreBar(
                                label: "Availability",
                                score: 100,
                              ),

                              const SizedBox(height: 12),

                              const Text(
                                "Why this match?",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),

                              const SizedBox(height: 4),

                              const Text(
                                "This candidate has strong experience in required skills and is fully available.",
                              ),
                            ],
                          )
                        : const SizedBox(),
                  ),
                ],
              ),

              /// MATCH BADGE
              Positioned(right: 0, top: -10, child: MatchBadge(match: 98)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _info(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [Icon(icon, size: 16), const SizedBox(width: 4), Text(text)],
    );
  }
}
