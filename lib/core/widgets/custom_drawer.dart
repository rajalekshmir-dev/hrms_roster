import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms_roster/core/constant/colors.dart';
import 'package:hrms_roster/core/constant/text_style.dart';
import 'package:hrms_roster/core/di/service_locator.dart';
import 'package:hrms_roster/core/widgets/alert_card.dart';
import 'package:hrms_roster/features/login/presentation/bloc/auth_state.dart';
import 'package:hrms_roster/features/upskill/presentation/bloc/upskill_bloc.dart';
import 'package:hrms_roster/features/upskill/presentation/bloc/upskill_event.dart';
import 'package:hrms_roster/features/upskill/presentation/pages/project_suggestion_page.dart';
import 'package:hrms_roster/features/upskill/presentation/pages/upskill_suggestion_page.dart';
import '../../features/login/presentation/bloc/auth_bloc.dart';
import '../../features/login/presentation/bloc/auth_event.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Drawer Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColors.kSoftColor,
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 12),

                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is Authenticated) {
                      return Column(
                        children: [
                          Text(
                            state.user.username,
                            style: AppTextStyles.headline.copyWith(
                              color: AppColors.kSoftColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                        ],
                      );
                    }
                    return Column(
                      children: [
                        Text(
                          'Guest User',
                          style: AppTextStyles.headline.copyWith(
                            color: AppColors.kSoftColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          ListTile(
            leading: Image.asset(
              "assets/images/skill_suggestion_icon.png",
              width: 26,
              height: 26,
              color: Theme.of(context).iconTheme.color,
            ),
            title: const Text('Upskill Suggestions'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) =>
                        sl<UpskillBloc>()..add(LoadUpskillSuggestions()),
                    child: const UpskillSuggestionPage(),
                  ),
                ),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.business_center),
            title: const Text('Project Recommendations'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) =>
                        sl<UpskillBloc>()..add(LoadUpskillSuggestions()),
                    child: const ProjectSuggestionPage(),
                  ),
                ),
              );
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.logout, color: AppColors.error),
            title: const Text(
              'Logout',
              style: TextStyle(color: AppColors.error),
            ),
            onTap: () {
              _handleLogout(context);
            },
          ),
        ],
      ),
    );
  }

  void _handleLogout(BuildContext context) {
    AlertCard.show(
      context: context,
      title: 'Logout',
      message: 'Are you sure you want to logout?',
      confirmText: 'Logout',
      cancelText: 'Cancel',
      confirmButtonColor: AppColors.error,
      // icon: Icons.logout_outlined,
      onConfirm: () => _performLogout(context),
    );
  }

  void _performLogout(BuildContext context) {
    context.read<AuthBloc>().add(LogoutRequested());
  }
}
