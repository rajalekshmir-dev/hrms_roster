import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms_roster/features/search_info/presentation/bloc/search_state.dart';
import 'package:hrms_roster/features/search_info/presentation/widgets/EmployeeCard.dart';
import 'package:hrms_roster/features/search_info/presentation/widgets/SearchBarWidget.dart';

import '../../../core/widgets/HRMSAppBar.dart';
import '../../../core/widgets/common_drop_down.dart';
import '../../../core/widgets/multi_select_dropdown.dart';
import 'bloc/search_bloc.dart';
import 'bloc/search_event.dart';

class SearchAiQueryData extends StatefulWidget {
  const SearchAiQueryData({super.key});

  @override
  State<SearchAiQueryData> createState() => _SearchAiQueryDataState();
}

class _SearchAiQueryDataState extends State<SearchAiQueryData> {
  final TextEditingController searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<EmployeeSearchBloc, EmployeeSearchState>(
              builder: (context, state) {
                if (state is EmployeeLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is EmployeeLoaded) {
                  final employees = state.employee.data;

                  /// NO DATA CASE
                  if (employees.isEmpty) {
                    return const Center(
                      child: Text(
                        "No Data Found",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }
                  return Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 180,
                              child: MultiSelectDropdown(
                                title: "Skills",
                                items: state.department,
                                onChanged: (values) {
                                  context.read<EmployeeSearchBloc>().add(
                                    FilterEmployeesEvent(techGroups: values),
                                  );
                                },
                              ),
                            ),

                            const SizedBox(width: 10),

                            SizedBox(
                              width: 180,
                              child: CommonDropdown(
                                title: "Tech Group",
                                items: state.techGroups,
                                onChanged: (value) {
                                  context.read<EmployeeSearchBloc>().add(
                                    FilterEmployeesEvent(
                                      techGroups: value != null
                                          ? [value]
                                          : null,
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              width: 180,
                              child: CommonDropdown(
                                title: "Experiences",
                                items: state.experiences,
                                onChanged: (value) {
                                  context.read<EmployeeSearchBloc>().add(
                                    FilterEmployeesEvent(
                                      techGroups: value != null
                                          ? [value]
                                          : null,
                                    ),
                                  );
                                },
                              ),
                            ),

                            const SizedBox(width: 10),

                            SizedBox(
                              width: 180,
                              child: CommonDropdown(
                                title: "Location",
                                items: state.locations,
                                onChanged: (value) {
                                  context.read<EmployeeSearchBloc>().add(
                                    FilterEmployeesEvent(location: value),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// EMPLOYEE LIST
                      Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: employees.length,
                          itemBuilder: (context, index) {
                            return EmployeeCard(employee: employees[index]);
                          },
                        ),
                      ),
                    ],
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
