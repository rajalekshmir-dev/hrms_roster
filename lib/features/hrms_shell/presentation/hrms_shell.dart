import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms_roster/core/widgets/custom_drawer.dart';
import 'package:hrms_roster/features/Home/presentation/pages/Home_page.dart';
import '../../../core/widgets/HRMSAppBar.dart';
import '../../../core/widgets/hrms_bottom_nav_bar.dart';
import '../../search_info/presentation/bloc/search_bloc.dart';
import '../../search_info/presentation/bloc/search_event.dart';
import '../../search_info/presentation/bloc/search_state.dart';
import '../../search_info/presentation/search_view.dart';
import '../../search_info/presentation/widgets/SearchBarWidget.dart';
import '../../users_info/presentation/users_info_view.dart';
import 'bloc/hrms_navigation_bloc.dart';
import 'bloc/hrms_navigation_event.dart';
import 'bloc/hrms_navigation_state.dart';
import '../../login/presentation/bloc/auth_bloc.dart';
import '../../login/presentation/bloc/auth_state.dart';
import '../../login/presentation/pages/login_page.dart';

class HRMSShell extends StatelessWidget {
  HRMSShell({super.key});

  final TextEditingController searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final pages = [HomePage(), UserInfoPage(), SearchAiQueryData()];

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // If user becomes unauthenticated, navigate to login
        if (state is Unauthenticated) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (Route<dynamic> route) => false,
          );
        }
      },
      child: BlocListener<EmployeeSearchBloc, EmployeeSearchState>(
        listener: (context, state) {
          if (state is EmployeeLoading) {
            context.read<NavigationBloc>().add(ChangePageEvent(2));
          }
        },
        child: Scaffold(
          key: _scaffoldKey,
          appBar: HRMSAppBar(scaffoldKey: _scaffoldKey),
          drawer: const CustomDrawer(),

          body: Column(
            children: [
              /// COMMON SEARCH BAR
              HRMSSearchBar(
                controller: searchController,
                onSearch: (query) {
                  context.read<EmployeeSearchBloc>().add(
                    SearchEmployeeEvent(query: query),
                  );
                },
              ),

              /// PAGE SWITCH
              Expanded(
                child: BlocBuilder<NavigationBloc, NavigationState>(
                  builder: (context, state) {
                    return IndexedStack(
                      index: state.currentIndex,
                      children: pages,
                    );
                  },
                ),
              ),
            ],
          ),

          /// BOTTOM NAV BAR
          bottomNavigationBar: SafeArea(
            top: false,
            child: BlocBuilder<NavigationBloc, NavigationState>(
              builder: (context, state) {
                return HRMSBottomNavBar(
                  currentIndex: state.currentIndex,
                  onTap: (index) {
                    context.read<NavigationBloc>().add(ChangePageEvent(index));
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
