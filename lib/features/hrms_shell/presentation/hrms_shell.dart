import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms_roster/features/Home/presentation/view/Home_page.dart';

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

class HRMSShell extends StatelessWidget {
  HRMSShell({super.key});

  final TextEditingController searchController = TextEditingController();

  final pages = [HomePage(), UserInfoPage(), SearchAiQueryData()];

  @override
  Widget build(BuildContext context) {
    return BlocListener<EmployeeSearchBloc, EmployeeSearchState>(
      listener: (context, state) {
        if (state is EmployeeLoading) {
          context.read<NavigationBloc>().add(ChangePageEvent(2));
        }
      },
      child: Scaffold(
        appBar: HRMSAppBar(),

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

        /// ✅ REPLACED WITH COMMON BOTTOM NAV BAR
        bottomNavigationBar: BlocBuilder<NavigationBloc, NavigationState>(
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
    );
  }
}
