import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms_roster/features/search_info/presentation/bloc/search_state.dart';
import 'package:hrms_roster/features/search_info/presentation/widgets/EmployeeCard.dart';
import 'package:hrms_roster/features/search_info/presentation/widgets/SearchBarWidget.dart';

import '../../../core/widgets/common_drop_down.dart';
import '../../../core/widgets/multi_select_dropdown.dart';
import 'bloc/search_bloc.dart';

class SearchAiQueryData extends StatelessWidget {
  const SearchAiQueryData({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HRMSSearchBar(controller: TextEditingController(), onSearch: () {}),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              CommonDropdown(
                title: "Department",
                items: ["Mobile", "Backend", "AI"],
                onChanged: (value) {},
              ),

              CommonDropdown(
                title: "Experience",
                items: ["0-2", "3-5", "6-10", "10+"],
                onChanged: (value) {},
              ),

              CommonDropdown(
                title: "Location",
                items: ["Kochi", "Bangalore"],
                onChanged: (value) {},
              ),

              MultiSelectDropdown(
                title: "Tech Group",
                items: ["Android", "iOS", "Flutter", "Management"],
                onChanged: (values) {},
              ),
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<EmployeeSearchBloc, EmployeeSearchState>(
            buildWhen: (previous, current) =>
                current is EmployeeLoaded ||
                current is EmployeeLoading ||
                current is EmployeeError,
            builder: (context, state) {
              if (state is EmployeeLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is EmployeeLoaded) {
                final employees = state.employee.data;

                return ListView.builder(
                  itemCount: employees.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return EmployeeCard(employee: employees[index]);
                  },
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }
}
