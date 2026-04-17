import 'package:flutter/material.dart';
import '../../../../core/constant/colors.dart';
import '../../../../core/constant/text_style.dart';
import '../../domain/entities/upskill_entities.dart';

class UpskillSuggestionCard extends StatelessWidget {
  final UpskillSuggestion upskillSuggestion;
  final bool isExpanded;
  final VoidCallback onToggle;

  const UpskillSuggestionCard({
    super.key,
    required this.upskillSuggestion,
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
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.kSoftColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _getDomainIcon(upskillSuggestion.domain),
                      color: AppColors.kPrimaryColor,
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Expanded(
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text(
                  //         upskillSuggestion.displayName,
                  //         style: AppTextStyles.title.copyWith(
                  //           fontSize: 16,
                  //           color: AppColors.kHeadingColor,
                  //         ),
                  //       ),
                  //       const SizedBox(height: 4),
                  //       Row(
                  //         children: [
                  //           Text(
                  //             '${upskillSuggestion.techGroup} ',
                  //             style: AppTextStyles.caption.copyWith(
                  //               color: AppColors.kLightTextColor,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       const SizedBox(height: 4),
                  //       Container(
                  //         padding: const EdgeInsets.symmetric(
                  //           horizontal: 8,
                  //           vertical: 2,
                  //         ),
                  //         decoration: BoxDecoration(
                  //           color: _getSeniorityColor(
                  //             upskillSuggestion.seniority,
                  //           ).withOpacity(0.1),
                  //           borderRadius: BorderRadius.circular(12),
                  //         ),
                  //         child: Text(
                  //           upskillSuggestion.seniority.toUpperCase(),
                  //           style: AppTextStyles.badge.copyWith(
                  //             color: _getSeniorityColor(
                  //               upskillSuggestion.seniority,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          upskillSuggestion.displayName,
                          style: AppTextStyles.title.copyWith(
                            fontSize: 16,
                            color: AppColors.kHeadingColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              upskillSuggestion.techGroup,
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.kLightTextColor,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: _getSeniorityColor(
                                  upskillSuggestion.seniority,
                                ).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                upskillSuggestion.seniority.toUpperCase(),
                                style: AppTextStyles.badge.copyWith(
                                  color: _getSeniorityColor(
                                    upskillSuggestion.seniority,
                                  ),
                                ),
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
                  // const SizedBox(height: 16),

                  // // Current Skills
                  // if (upskillSuggestion.primarySkills.isNotEmpty) ...[
                  //   Text(
                  //     'Current Skills',
                  //     style: AppTextStyles.subtitle.copyWith(
                  //       fontWeight: FontWeight.w600,
                  //     ),
                  //   ),
                  //   const SizedBox(height: 8),
                  //   Wrap(
                  //     spacing: 8,
                  //     runSpacing: 8,
                  //     children: upskillSuggestion.primarySkills.map((skill) {
                  //       return Container(
                  //         padding: const EdgeInsets.symmetric(
                  //           horizontal: 10,
                  //           vertical: 6,
                  //         ),
                  //         decoration: BoxDecoration(
                  //           color: Colors.green.withOpacity(0.1),
                  //           borderRadius: BorderRadius.circular(20),
                  //         ),
                  //         child: Text(
                  //           skill,
                  //           style: AppTextStyles.caption.copyWith(
                  //             color: Colors.green.shade700,
                  //           ),
                  //         ),
                  //       );
                  //     }).toList(),
                  //   ),
                  //   const SizedBox(height: 16),
                  // ],

                  // Upskill Suggestions List
                  // Text(
                  //   'Suggested Upskills',
                  //   style: AppTextStyles.subtitle.copyWith(
                  //     fontWeight: FontWeight.w600,
                  //   ),
                  // ),
                  // const SizedBox(height: 12),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: upskillSuggestion.upskillSuggestions.length,
                    itemBuilder: (context, index) {
                      final upskill =
                          upskillSuggestion.upskillSuggestions[index];
                      return _buildUpskillDetailCard(upskill, index);
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildUpskillDetailCard(UpskillDetail upskill, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.kAssistantBaseStart,
            AppColors.kAssistantBaseStart.withOpacity(0.5),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.kAssistantGlowSecondary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.kPrimaryColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  upskill.skill,
                  style: AppTextStyles.subtitle.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.kHeadingColor,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 12,
                      color: Colors.orange,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${upskill.estimatedWeeks} weeks',
                      style: AppTextStyles.badge.copyWith(
                        color: Colors.orange.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Why this skill?',
            style: AppTextStyles.caption.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.kPrimaryColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            upskill.reason,
            style: AppTextStyles.body.copyWith(fontSize: 12),
          ),
          const SizedBox(height: 12),
          Text(
            'Learning Path',
            style: AppTextStyles.caption.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.kPrimaryColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            upskill.learningPath,
            style: AppTextStyles.body.copyWith(fontSize: 12),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.kSoftColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.business, size: 16, color: AppColors.kPrimaryColor),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    upskill.relevanceToCompany,
                    style: AppTextStyles.caption.copyWith(
                      fontSize: 11,
                      color: AppColors.kHeadingColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getDomainIcon(String domain) {
    switch (domain.toLowerCase()) {
      case 'java':
        return Icons.code;
      case 'python':
        return Icons.terminal;
      case 'react':
        return Icons.web;
      case 'angular':
        return Icons.web_asset;
      case 'android':
        return Icons.android;
      case 'dotnet':
        return Icons.window;
      case 'qa_manual':
      case 'qa_auto':
        return Icons.bug_report;
      case 'devops':
        return Icons.cloud;
      case 'embedded':
        return Icons.memory;
      default:
        return Icons.person;
    }
  }

  Color _getSeniorityColor(String seniority) {
    switch (seniority.toLowerCase()) {
      case 'director':
        return Colors.deepPurple;
      case 'lead':
        return Colors.purple;
      case 'senior':
        return Colors.blue;
      case 'mid':
        return Colors.green;
      case 'junior':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
