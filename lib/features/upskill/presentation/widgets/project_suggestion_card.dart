import 'package:flutter/material.dart';
import '../../../../core/constant/colors.dart';
import '../../../../core/constant/text_style.dart';
import '../../domain/entities/upskill_entities.dart';

class ProjectSuggestionCard extends StatelessWidget {
  final ProjectSuggestion project;
  final bool isExpanded;
  final VoidCallback onToggle;

  const ProjectSuggestionCard({
    super.key,
    required this.project,
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          InkWell(
            onTap: onToggle,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.projectTitle,
                          style: AppTextStyles.title.copyWith(
                            fontSize: 16,
                            color: AppColors.kHeadingColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: project.techStack.map((tech) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.kSoftColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                tech.toUpperCase(),
                                style: AppTextStyles.badge.copyWith(
                                  color: AppColors.kPrimaryColor,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 14,
                              color: AppColors.kLightTextColor,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              project.estimatedDuration,
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.kLightTextColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: AppColors.kPrimaryColor,
                  ),
                ],
              ),
            ),
          ),

          // Expanded Content
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  const SizedBox(height: 16),

                  // Description
                  Text(
                    'Description',
                    style: AppTextStyles.subtitle.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(project.description, style: AppTextStyles.body),
                  const SizedBox(height: 16),

                  // Business Value
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.kSoftColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.business_center,
                          size: 20,
                          color: AppColors.kPrimaryColor,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Business Value',
                                style: AppTextStyles.caption.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.kPrimaryColor,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                project.businessValue,
                                style: AppTextStyles.body.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Required Roles
                  Text(
                    'Required Roles :',
                    style: AppTextStyles.subtitle.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: project.requiredRoles.map((role) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Text(role, style: AppTextStyles.caption),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),

                  // Team Assignments Section
                  Row(
                    children: [
                      Icon(
                        Icons.group,
                        size: 20,
                        color: AppColors.kPrimaryColor,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Suggested Team Members',
                        style: AppTextStyles.subtitle.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: project.teamAssignments.length,
                    itemBuilder: (context, index) {
                      final assignment = project.teamAssignments[index];
                      return _buildTeamAssignmentCard(assignment);
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTeamAssignmentCard(TeamAssignment assignment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.kDashboardBgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.kPrimaryColor.withOpacity(0.1),
                child: Text(
                  assignment.displayName[0].toUpperCase(),
                  style: TextStyle(
                    color: AppColors.kPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      assignment.displayName,
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        assignment.employeeId,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.kLightTextColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      assignment.assignedRole,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.kPrimaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: assignment.seniority == 'lead'
                      ? Colors.purple.withOpacity(0.1)
                      : Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  assignment.seniority.toUpperCase(),
                  style: AppTextStyles.badge.copyWith(
                    color: assignment.seniority == 'lead'
                        ? Colors.purple
                        : Colors.green,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            assignment.reason,
            style: AppTextStyles.body.copyWith(fontSize: 12),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: assignment.primarySkills.map((skill) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.kSoftColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  skill,
                  style: AppTextStyles.caption.copyWith(fontSize: 10),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
