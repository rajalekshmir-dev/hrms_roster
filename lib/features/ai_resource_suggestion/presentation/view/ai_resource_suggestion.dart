import 'package:flutter/material.dart';
import 'package:hrms_roster/features/ai_resource_suggestion/presentation/view/widgets/ai_resource_suggestion.dart';
import 'package:hrms_roster/features/ai_resource_suggestion/presentation/view/widgets/ai_resourse_heading_section.dart';

class RequirementListSection extends StatelessWidget {
  const RequirementListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// HEADER
        const RequirementsHeader(),
        Expanded(
          child: ListView.builder(
            itemCount: 5,
            padding: const EdgeInsets.only(top: 6),
            itemBuilder: (context, index) {
              return RequirementCard(
                project: "ABXU_MAPP",
                client: "Aerobitix USA LLC",
                requirement: "React with less than 4 yrs experience",
                updatedAt: "14 Apr 2026, 5:38 AM",
                icon: Icons.code,
                color: Colors.blue,
              );
            },
          ),
        ),
      ],
    );
  }
}
