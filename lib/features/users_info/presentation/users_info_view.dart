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

  @override
  void initState() {
    super.initState();

    context.read<UserInfoBloc>().add(FetchUserInfo());
  }

  void onSearch(String query) {
    context.read<UserInfoBloc>().add(SearchUsers(query));
  }

  @override
  Widget build(BuildContext context) {
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

                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];

                    return UserInfoCard(
                      name: user.displayName ?? '',
                      id: user.employeeId ?? '',
                      designation: user.designation ?? '',
                      skills: user.techGroup ?? '',
                    );
                  },
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
}
