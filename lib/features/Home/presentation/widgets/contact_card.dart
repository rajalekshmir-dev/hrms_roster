import 'package:flutter/material.dart';
import 'package:hrms_roster/features/Home/domain/entities/directory_contact.dart';
import 'package:hrms_roster/features/Home/presentation/pages/employee_detail_page.dart';

class ContactCard extends StatelessWidget {
  final DirectoryContact contact;

  const ContactCard({super.key, required this.contact});

  // Helper method to extract numeric ID from employee_id
  String _extractNumericId(String? employeeId) {
    if (employeeId == null || employeeId.isEmpty) return '';

    // If it contains '/', take the part after the last '/'
    if (employeeId.contains('/')) {
      final parts = employeeId.split('/');
      return parts.last;
    }

    // If it's already numeric or other format, return as is
    return employeeId;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: InkWell(
        onTap: () {
          final employeeId = contact.employeeId ?? contact.id;
          if (employeeId != null && employeeId.isNotEmpty) {
            final numericId = _extractNumericId(employeeId);
            print('Original Employee ID: $employeeId');
            print('Extracted Numeric ID: $numericId');

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EmployeeDetailPage(employeeId: numericId),
              ),
            );
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    contact.name.isNotEmpty
                        ? contact.name[0].toUpperCase()
                        : '?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contact.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      contact.title,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 12,
                          color: Colors.grey.shade500,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          contact.location,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey.shade400),
            ],
          ),
        ),
      ),
    );
  }
}
