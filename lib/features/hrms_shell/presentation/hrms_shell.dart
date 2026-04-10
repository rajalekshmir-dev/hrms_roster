import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/HRMSAppBar.dart';
import '../../search_info/presentation/search_view.dart';
import '../../search_info/presentation/widgets/SearchBarWidget.dart';
import '../../users_info/presentation/users_info_view.dart';
import 'bloc/hrms_navigation_bloc.dart';
import 'bloc/hrms_navigation_event.dart';
import 'bloc/hrms_navigation_state.dart';

class HRMSShell extends StatelessWidget {
  HRMSShell({super.key});

  final TextEditingController searchController = TextEditingController();

  final pages = [UserInfoPage(), SearchAiQueryData()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HRMSAppBar(),

      body: Column(
        children: [
          /// COMMON SEARCH
          HRMSSearchBar(controller: searchController, onSearch: () {}),

          /// PAGE SWITCH
          Expanded(
            child: BlocBuilder<NavigationBloc, NavigationState>(
              builder: (context, state) {
                return IndexedStack(index: state.currentIndex, children: pages);
              },
            ),
          ),
        ],
      ),

      bottomNavigationBar: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: state.currentIndex,
            onTap: (index) {
              context.read<NavigationBloc>().add(ChangePageEvent(index));
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: "Employees",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.work),
                label: "Projects",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.apartment),
                label: "Dept",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.psychology),
                label: "AI",
              ),
            ],
          );
        },
      ),
    );
  }
}
