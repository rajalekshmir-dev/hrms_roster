import 'package:flutter/material.dart';
import 'package:hrms_roster/features/search_info/data/models/search_info_model.dart';
import 'package:hrms_roster/features/search_info/presentation/widgets/SearchBarWidget.dart';

import 'core/theme/app_theme.dart';
import 'core/widgets/HRMSAppBar.dart';
import 'core/widgets/common_drop_down.dart';
import 'core/widgets/multi_select_dropdown.dart' show MultiSelectDropdown;
import 'features/search_info/presentation/widgets/EmployeeCard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      /// Apply your theme
      theme: AppTheme.lightTheme,

      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<EmployeeModel> employees = [
      EmployeeModel(
        id: '',
        name: "Divya Trivedi",
        designation: "Sr Principal Engineer (Software)",
        department: "Cloud and Mobile Apps",
        location: "Gurgaon",
        techGroup: "Frontend - ReactJS",
        totalExp: "13Y 5M",
        projectName: "NTGU_IMDV",
        occupancy: 100,
        skills: [
          "CSS",
          "Bootstrap",
          "Angular",
          "ReactJS",
          "JQuery",
          "HTML",
          "Javascript",
        ],
      ),
      EmployeeModel(
        id: '',
        name: "Divya Trivedi",
        designation: "Sr Principal Engineer (Software)",
        department: "Cloud and Mobile Apps",
        location: "Gurgaon",
        techGroup: "Frontend - ReactJS",
        totalExp: "13Y 5M",
        projectName: "NTGU_IMDV",
        occupancy: 100,
        skills: [
          "CSS",
          "Bootstrap",
          "Angular",
          "ReactJS",
          "JQuery",
          "HTML",
          "Javascript",
        ],
      ),
      EmployeeModel(
        id: '',
        name: "Divya Trivedi",
        designation: "Sr Principal Engineer (Software)",
        department: "Cloud and Mobile Apps",
        location: "Gurgaon",
        techGroup: "Frontend - ReactJS",
        totalExp: "13Y 5M",
        projectName: "NTGU_IMDV",
        occupancy: 100,
        skills: [
          "CSS",
          "Bootstrap",
          "Angular",
          "ReactJS",
          "JQuery",
          "HTML",
          "Javascript",
        ],
      ),
      EmployeeModel(
        id: '',
        name: "Divya Trivedi",
        designation: "Sr Principal Engineer (Software)",
        department: "Cloud and Mobile Apps",
        location: "Gurgaon",
        techGroup: "Frontend - ReactJS",
        totalExp: "13Y 5M",
        projectName: "NTGU_IMDV",
        occupancy: 100,
        skills: [
          "CSS",
          "Bootstrap",
          "Angular",
          "ReactJS",
          "JQuery",
          "HTML",
          "Javascript",
        ],
      ),
      EmployeeModel(
        id: '',
        name: "Divya Trivedi",
        designation: "Sr Principal Engineer (Software)",
        department: "Cloud and Mobile Apps",
        location: "Gurgaon",
        techGroup: "Frontend - ReactJS",
        totalExp: "13Y 5M",
        projectName: "NTGU_IMDV",
        occupancy: 100,
        skills: [
          "CSS",
          "Bootstrap",
          "Angular",
          "ReactJS",
          "JQuery",
          "HTML",
          "Javascript",
        ],
      ),
      EmployeeModel(
        id: '',
        name: "Divya Trivedi",
        designation: "Sr Principal Engineer (Software)",
        department: "Cloud and Mobile Apps",
        location: "Gurgaon",
        techGroup: "Frontend - ReactJS",
        totalExp: "13Y 5M",
        projectName: "NTGU_IMDV",
        occupancy: 100,
        skills: [
          "CSS",
          "Bootstrap",
          "Angular",
          "ReactJS",
          "JQuery",
          "HTML",
          "Javascript",
        ],
      ),
      EmployeeModel(
        id: '',
        name: "Divya Trivedi",
        designation: "Sr Principal Engineer (Software)",
        department: "Cloud and Mobile Apps",
        location: "Gurgaon",
        techGroup: "Frontend - ReactJS",
        totalExp: "13Y 5M",
        projectName: "NTGU_IMDV",
        occupancy: 100,
        skills: [
          "CSS",
          "Bootstrap",
          "Angular",
          "ReactJS",
          "JQuery",
          "HTML",
          "Javascript",
        ],
      ),
      EmployeeModel(
        id: '',
        name: "Divya Trivedi",
        designation: "Sr Principal Engineer (Software)",
        department: "Cloud and Mobile Apps",
        location: "Gurgaon",
        techGroup: "Frontend - ReactJS",
        totalExp: "13Y 5M",
        projectName: "NTGU_IMDV",
        occupancy: 100,
        skills: [
          "CSS",
          "Bootstrap",
          "Angular",
          "ReactJS",
          "JQuery",
          "HTML",
          "Javascript",
        ],
      ),
      EmployeeModel(
        id: '',
        name: "Divya Trivedi",
        designation: "Sr Principal Engineer (Software)",
        department: "Cloud and Mobile Apps",
        location: "Gurgaon",
        techGroup: "Frontend - ReactJS",
        totalExp: "13Y 5M",
        projectName: "NTGU_IMDV",
        occupancy: 100,
        skills: [
          "CSS",
          "Bootstrap",
          "Angular",
          "ReactJS",
          "JQuery",
          "HTML",
          "Javascript",
        ],
      ),
    ];
    return Scaffold(
      appBar: HRMSAppBar(),
      body: Column(
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
            child: ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) {
                return EmployeeCard(employee: employees[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
