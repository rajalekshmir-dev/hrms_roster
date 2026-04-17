import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms_roster/core/widgets/common_loading_container.dart';
import '../../../../core/constant/colors.dart';
import '../../../../core/widgets/HRMSAppBar.dart';
import '../../../../core/widgets/common_empty_state.dart';
import '../../../../core/widgets/common_error_state.dart';
import '../bloc/upskill_bloc.dart';
import '../bloc/upskill_event.dart';
import '../bloc/upskill_state.dart';
import '../widgets/upskill_suggestion_card.dart';

class UpskillSuggestionPage extends StatelessWidget {
  const UpskillSuggestionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kDashboardBgColor,
      appBar: HRMSAppBar(
        showBackButton: true,
        showMenuIcon: false,
        showThemeToggle: false,
        showNotificationBadge: false,
        title: 'Upskill Suggestions',
      ),
      body: BlocBuilder<UpskillBloc, UpskillState>(
        builder: (context, state) {
          if (state.status == UpskillStatus.loading) {
            return const CommonLoadingContainer(
              isLoading: true,
              child: SizedBox(),
            );
          }

          if (state.status == UpskillStatus.error) {
            return CommonErrorState(
              message: state.errorMessage ?? 'Something went wrong',
              onRetry: () {
                context.read<UpskillBloc>().add(LoadUpskillSuggestions());
              },
            );
          }

          if (state.data == null || state.data!.response.isEmpty) {
            return CommonEmptyState(
              message: 'No upskill suggestions available',
              icon: Icons.lightbulb_outline,
            );
          }

          final upskillData = state.data!.response.first;

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
                  if (upskillData.upskillSuggestions.isEmpty)
                    CommonEmptyState(
                      message: 'No upskill suggestions available',
                      icon: Icons.lightbulb_outline,
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: upskillData.upskillSuggestions.length,
                      itemBuilder: (context, index) {
                        return UpskillSuggestionCard(
                          upskillSuggestion:
                              upskillData.upskillSuggestions[index],
                          isExpanded: state.expandedUpskillSuggestions.contains(
                            index,
                          ),
                          onToggle: () {
                            context.read<UpskillBloc>().add(
                              ToggleUpskillExpansion(index),
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
