import 'package:flutter/material.dart';
import 'package:hrms_roster/features/users_info/presentation/widgets/small_search_bar.dart';
import 'package:hrms_roster/features/users_info/presentation/widgets/user_info_card.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final TextEditingController searchController = TextEditingController();

  final employees = [
    {
      "name": "Gopika E",
      "id": "VVDN/13041",
      "designation": "Flutter Developer",
      "skills": "Flutter,Dart,Firebase",
    },
    {
      "name": "Rahul Kumar",
      "id": "VVDN/12012",
      "designation": "Backend Developer",
      "skills": "NodeJS,Python,API",
    },
  ];

  List<Map<String, String>> filtered = [];

  @override
  void initState() {
    filtered = employees;
    super.initState();
  }

  void filter(String query) {
    setState(() {
      filtered = employees.where((emp) {
        final skill = emp["skills"]!.toLowerCase();
        final des = emp["designation"]!.toLowerCase();
        return skill.contains(query.toLowerCase()) ||
            des.contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// SMALL SEARCH BAR
        SmallSearchBar(controller: searchController, onChanged: filter),

        /// USER CARDS
        Expanded(
          child: ListView.builder(
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              final emp = filtered[index];

              return UserInfoCard(
                name: emp["name"]!,
                id: emp["id"]!,
                designation: emp["designation"]!,
                skills: emp["skills"]!,
              );
            },
          ),
        ),
      ],
    );
  }
}
