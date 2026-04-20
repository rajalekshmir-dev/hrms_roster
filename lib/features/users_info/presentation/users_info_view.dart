import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms_roster/features/users_info/presentation/widgets/small_search_bar.dart';
import 'package:hrms_roster/features/users_info/presentation/widgets/user_info_card.dart';

import 'bloc/users_info_bloc.dart';
import 'bloc/users_info_event.dart';
import 'bloc/users_info_state.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<UserInfoBloc>().add(FetchUserInfo());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }

  void onSearch(String query) {
    context.read<UserInfoBloc>().add(SearchUsers(query));
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    return Column(
      children: [
        /// SEARCH BAR
        SmallSearchBar(controller: searchController, onChanged: onSearch),

        /// USER LIST
        Expanded(
          child: BlocBuilder<UserInfoBloc, UserInfoState>(
            builder: (context, state) {
              if (state is UserInfoLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is UserInfoLoaded) {
                final users = state.users;

                if (users.isEmpty) {
                  return Center(
                    child: Text(
                      "No Data Found",
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.6),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }

                return Column(
                  children: [
                    /// HEADER (NOW IT WILL SHOW)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      child: Row(
                        children: [
                          /// TITLE
                          const Text(
                            "Employees",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(width: 8),

                          /// COUNT
                          Text(
                            "${users.length} / 500",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          const Spacer(),

                          /// SCROLL BUTTONS
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey.shade100,
                            ),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    _scrollController.animateTo(
                                      _scrollController.offset - 250,
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(6),
                                    child: Icon(
                                      Icons.keyboard_arrow_up,
                                      size: 20,
                                    ),
                                  ),
                                ),

                                Container(
                                  height: 18,
                                  width: 1,
                                  color: Colors.grey.shade300,
                                ),

                                InkWell(
                                  onTap: () {
                                    _scrollController.animateTo(
                                      _scrollController.offset + 250,
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(6),
                                    child: Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// LIST
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final user = users[index];

                          return UserInfoCard(
                            name: user.displayName ?? '',
                            id: user.employeeId ?? '',
                            designation: user.designation ?? '',
                            skills: user.skillSet ?? '',
                            onAddSkill: () {
                              _showAddSkillDialog(user.employeeId ?? '');
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              }

              if (state is UserInfoError) {
                return Center(child: Text(state.message));
              }

              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }

  void _showAddSkillDialog(String employeeId) {
    final TextEditingController skillController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Skill"),
          content: TextField(
            controller: skillController,
            decoration: const InputDecoration(hintText: "Enter Skill"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final skill = skillController.text.trim();

                if (skill.isNotEmpty) {
                  context.read<UserInfoBloc>().add(AddSkill(employeeId, skill));
                }

                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }
}
