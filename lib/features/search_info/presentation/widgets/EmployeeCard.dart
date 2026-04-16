import 'package:flutter/material.dart';
import 'package:hrms_roster/core/constant/text_style.dart';

import '../../../../core/widgets/common_card.dart';
import '../../data/models/search_info_model.dart';
import 'employee_card_expended.dart';
import 'liner_graph.dart';
import 'match_badge.dart';

class EmployeeCard extends StatefulWidget {
  final Datum employee;

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
    final project = employee.projects.isNotEmpty
        ? employee.projects.first
        : null;
    return GestureDetector(
      onTap: () {
        setState(() {
          expanded = !expanded;
        });
      },
      child: RepaintBoundary(
        child: CommonAnimatedCard(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              employee.displayName ?? '',
                              style: AppTextStyles.title,
                            ),
                            Text(
                              employee.designation ?? '',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// Expand icon animation
                      AnimatedRotation(
                        duration: const Duration(milliseconds: 300),
                        turns: expanded ? 0.5 : 0,
                        child: const Icon(Icons.keyboard_arrow_down),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  /// INFO DETAILS
                  Wrap(
                    spacing: 18,
                    runSpacing: 8,
                    children: [
                      _info(Icons.badge_outlined, employee.employeeId ?? ""),
                      _info(
                        Icons.business_outlined,
                        employee.employeeDepartment ?? "",
                      ),
                      _info(
                        Icons.location_on_outlined,
                        employee.empLocation ?? "",
                      ),
                      _info(Icons.code_outlined, employee.techGroup ?? ""),
                      _info(Icons.timeline_outlined, employee.totalExp ?? ""),
                    ],
                  ),

                  const SizedBox(height: 12),

                  /// PROJECT BADGE
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue.shade400, Colors.blue.shade600],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "${project?.projectName ?? ""} • ${project?.occupancy ?? 0}%",
                      style: AppTextStyles.subtitle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// SKILLS
                  const Text("Skills", style: AppTextStyles.sectionTitle),

                  const SizedBox(height: 6),

                  const SizedBox(height: 14),

                  ExpandableSkills(skills: employee.skillSet?.split(",") ?? []),

                  MatchOverviewGraph(
                    skill: employee.aiCriteria?.skill?.toInt() ?? 0,
                    experience: employee.aiCriteria?.experience?.toInt() ?? 0,
                    availability:
                        employee.aiCriteria?.availability?.toInt() ?? 0,
                  ),

                  const SizedBox(height: 10),

                  /// EXPANDABLE SECTION
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: expanded
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 14),
                              Divider(color: Colors.grey.shade300),
                              const SizedBox(height: 10),
                              const Text(
                                "Match Score",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 14),
                              const Text(
                                "Why this match?",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                employee.aiReason ?? '',
                                style: TextStyle(color: Colors.grey.shade700),
                              ),
                            ],
                          )
                        : const SizedBox(),
                  ),
                ],
              ),

              /// MATCH BADGE
              Positioned(
                right: 20,
                top: -14,
                child: MatchBadge(match: employee.aiScore ?? 0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _info(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.grey.shade600),
        const SizedBox(width: 4),
        Text(text, style: TextStyle(color: Colors.grey.shade700, fontSize: 13)),
      ],
    );
  }
}
