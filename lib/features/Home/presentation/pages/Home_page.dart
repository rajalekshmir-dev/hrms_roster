import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms_roster/core/constant/colors.dart';
import 'package:hrms_roster/core/constant/text_style.dart';
import 'package:hrms_roster/core/widgets/reusable_search_bar.dart';
import 'package:hrms_roster/features/Home/presentation/widgets/stats_overview_card.dart';
import 'package:hrms_roster/features/Home/presentation/widgets/contact_card.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(LoadHomeData());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kDashboardBgColor,
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.status == HomeStatus.loading &&
              state.directoryContacts.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading...'),
                ],
              ),
            );
          }

          if (state.status == HomeStatus.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: AppColors.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.errorMessage ?? 'Something went wrong',
                    style: AppTextStyles.body,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<HomeBloc>().add(RefreshHomeData());
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.kPrimaryColor,
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<HomeBloc>().add(RefreshHomeData());
            },
            color: AppColors.kPrimaryColor,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: StatsOverviewCard(
                      totalEmployees: state.totalEmployees,
                      activeProjects: state.activeProjects,
                      freePool: state.freePoolCount,
                    ),
                  ),
                  const SizedBox(height: 24),

                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Employee Directory',
                                style: AppTextStyles.headline,
                              ),
                              if (state.searchQuery.isEmpty &&
                                  state.totalPages > 1)
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: state.currentPage > 1
                                          ? () {
                                              context.read<HomeBloc>().add(
                                                GoToPage(state.currentPage - 1),
                                              );
                                            }
                                          : null,
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        color: state.currentPage > 1
                                            ? AppColors.kPrimaryColor
                                            : Colors.grey.shade400,
                                        size: 16,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.kSoftColor,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        '${state.currentPage}/${state.totalPages}',
                                        style: AppTextStyles.caption.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.kPrimaryColor,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    GestureDetector(
                                      onTap: state.currentPage < state.totalPages
                                          ? () {
                                              context.read<HomeBloc>().add(
                                                GoToPage(state.currentPage + 1),
                                              );
                                            }
                                          : null,
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: state.currentPage < state.totalPages
                                            ? AppColors.kPrimaryColor
                                            : Colors.grey.shade400,
                                        size: 16,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          child: ReusableSearchBar(
                            controller: _searchController,
                            hintText: 'Search by name, title, or location...',
                            onSearchChanged: (query) {
                              if (query.isEmpty) {
                                context.read<HomeBloc>().add(ClearSearch());
                              } else {
                                final filteredQuery = query.replaceAll(
                                  RegExp(r'[^a-zA-Z\s\-\.]'),
                                  '',
                                );
                                if (filteredQuery != query) {
                                  _searchController.value = TextEditingValue(
                                    text: filteredQuery,
                                    selection: TextSelection.collapsed(
                                      offset: filteredQuery.length,
                                    ),
                                  );
                                }
                                context.read<HomeBloc>().add(
                                  SearchEmployees(filteredQuery),
                                );
                              }
                            },
                            onClearTap: () {
                              _searchController.clear();
                              context.read<HomeBloc>().add(ClearSearch());
                            },
                            onFilterTap: () {
                              _showFilterDialog(context);
                            },
                            showFilterButton: true,
                          ),
                        ),

                        const Divider(height: 1, thickness: 1, color: AppColors.kDashboardBgColor),

                        if (state.displayContacts.isEmpty &&
                            state.searchQuery.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.all(32),
                            child: Center(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.search_off,
                                    size: 48,
                                    color: Colors.grey.shade400,
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    'No results found for "${state.searchQuery}"',
                                    style: AppTextStyles.body.copyWith(
                                      color: AppColors.kLightTextColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 12),
                                  TextButton.icon(
                                    onPressed: () {
                                      _searchController.clear();
                                      context.read<HomeBloc>().add(ClearSearch());
                                    },
                                    icon: const Icon(Icons.clear, size: 18),
                                    label: const Text('Clear search'),
                                    style: TextButton.styleFrom(
                                      foregroundColor: AppColors.kPrimaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        else if (state.displayContacts.isEmpty)
                          const Padding(
                            padding: EdgeInsets.all(32),
                            child: Center(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.people_outline,
                                    size: 48,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    'No employees found',
                                    style: TextStyle(fontSize: 14, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          )
                        else
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(16),
                            itemCount: state.displayContacts.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              return ContactCard(
                                contact: state.displayContacts[index],
                              );
                            },
                          ),

                        if (state.isLoadingMore)
                          const Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(
                              child: SizedBox(
                                height: 40,
                                width: 40,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
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

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Filter Employees',
                  style: AppTextStyles.headline,
                ),
                const SizedBox(height: 16),
                _buildFilterOption(context, 'Department'),
                _buildFilterOption(context, 'Location'),
                _buildFilterOption(context, 'Designation'),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey.shade300),
                        ),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.kPrimaryColor,
                        ),
                        child: const Text('Apply'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilterOption(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Checkbox(
            value: false,
            onChanged: (value) {},
            activeColor: AppColors.kPrimaryColor,
          ),
          Text(title, style: AppTextStyles.body),
        ],
      ),
    );
  }
}