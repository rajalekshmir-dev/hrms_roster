import 'package:flutter/material.dart';
import 'package:hrms_roster/core/constant/colors.dart';
import 'package:hrms_roster/features/Home/domain/entities/department.dart';



class ProjectDistributionCard extends StatelessWidget {
  final List<Department> departments;
  final int totalEmployees;
  
  const ProjectDistributionCard({
    super.key,
    required this.departments,
    required this.totalEmployees,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Project Distribution',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      totalEmployees.toString(),
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppColors.kPrimaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Total employees',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _buildDepartmentList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildDepartmentList() {
    return Column(
      children: departments.map((dept) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Container(
                width: (dept.percentage * 0.8).clamp(20.0, 80.0),
                height: 8,
                decoration: BoxDecoration(
                  color: _getColorForDepartment(dept.name),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  dept.name,
                  style: const TextStyle(fontSize: 10, color: Color(0xFF64748B)),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '${dept.count}',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E293B),
                ),
              ),
            ],
          ),
        );
      }).take(5).toList(),
    );
  }
  
  Color _getColorForDepartment(String name) {
    switch (name.toLowerCase()) {
      case 'engineering':
        return Colors.blue.shade400;
      case 'product':
        return Colors.green.shade400;
      case 'sales':
        return Colors.orange.shade400;
      case 'hr':
        return Colors.purple.shade400;
      default:
        return Colors.grey.shade400;
    }
  }
}