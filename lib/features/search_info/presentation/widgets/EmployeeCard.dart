import 'package:flutter/material.dart';

import '../../data/models/search_info_model.dart';
import 'employee_card_expended.dart';

class EmployeeCard extends StatelessWidget {
  final EmployeeModel employee;

  const EmployeeCard({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Name + designation
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  employee.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            Text(
              employee.designation,
              style: const TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 10),

            /// Details
            Wrap(
              spacing: 16,
              runSpacing: 6,
              children: [
                _info(Icons.badge, employee.id),

                _info(Icons.business, employee.department),

                _info(Icons.location_on, employee.location),

                _info(Icons.code, employee.techGroup),

                _info(Icons.timeline, employee.totalExp),
              ],
            ),

            const SizedBox(height: 10),

            /// Project badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text("${employee.projectName} - ${employee.occupancy}%"),
            ),

            const SizedBox(height: 10),

            /// Skills
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Skills:",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),

                const SizedBox(height: 6),

                ExpandableSkills(skills: employee.skills),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _info(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [Icon(icon, size: 16), const SizedBox(width: 4), Text(text)],
    );
  }
}
