import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms_roster/core/widgets/HRMSAppBar.dart';
import '../../../../core/constant/colors.dart';
import '../../../../core/widgets/common_empty_state.dart';
import '../../../../core/widgets/common_error_state.dart';
import '../../../../core/widgets/common_loading_container.dart';
import '../bloc/upskill_bloc.dart';
import '../bloc/upskill_event.dart';
import '../bloc/upskill_state.dart';
import '../widgets/project_suggestion_card.dart';

class ProjectSuggestionPage extends StatelessWidget {
  const ProjectSuggestionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kDashboardBgColor,
      appBar: HRMSAppBar(
        showBackButton: true,
        showMenuIcon: false,
        showThemeToggle: false,
        showNotificationBadge: false,
        title: 'Project Recommendations',
      ),
      body: BlocBuilder<UpskillBloc, UpskillState>(
        builder: (context, state) {
          // Loading State
          if (state.status == UpskillStatus.loading) {
            return const CommonLoadingContainer(
              isLoading: true,
              child: SizedBox(),
            );
          }

          // Error State
          if (state.status == UpskillStatus.error) {
            return CommonErrorState(
              message: state.errorMessage ?? 'Something went wrong',
              onRetry: () {
                context.read<UpskillBloc>().add(LoadUpskillSuggestions());
              },
            );
          }

          // No Data State
          if (state.data == null || state.data!.response.isEmpty) {
            return CommonEmptyState(
              message: 'No project suggestions available',
              icon: Icons.lightbulb_outline,
            );
          }

          final upskillData = state.data!.response.first;

          // Refresh Indicator with Content
          return RefreshIndicator(
            onRefresh: () async {
              context.read<UpskillBloc>().add(RefreshUpskillSuggestions());
            },
            color: AppColors.kPrimaryColor,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Project Suggestions List
                  if (upskillData.projectSuggestions.isEmpty)
                    CommonEmptyState(
                      message: 'No project suggestions available',
                      icon: Icons.business_center_outlined,
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: upskillData.projectSuggestions.length,
                      itemBuilder: (context, index) {
                        return ProjectSuggestionCard(
                          project: upskillData.projectSuggestions[index],
                          isExpanded: state.expandedProjects.contains(index),
                          onToggle: () {
                            context.read<UpskillBloc>().add(
                              ToggleProjectExpansion(index),
                            );
                          },
                        );
                      },
                    ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
