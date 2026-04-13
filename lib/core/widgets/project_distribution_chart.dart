import 'package:flutter/material.dart';
import 'package:hrms_roster/features/Home/domain/entities/department.dart';

class ProjectDistributionChart extends StatelessWidget {
  final List<Department> departments;
  final int totalEmployees;

  const ProjectDistributionChart({
    super.key,
    required this.departments,
    required this.totalEmployees,
  });

  @override
  Widget build(BuildContext context) {
   
    final displayDepartments = departments.isEmpty
        ? _getDefaultDepartments()
        : departments;

    final total = displayDepartments.fold<int>(
      0,
      (sum, dept) => sum + dept.count,
    );

    final items = displayDepartments.map((dept) {
      final percentage = total > 0 ? (dept.count / total) * 100 : dept.percentage;
      return ProjectItem(
        name: dept.name.toUpperCase(),
        percentage: percentage,
        count: dept.count,
      );
    }).toList();

    // Separate top items and "Others"
    final topItems = items.take(4).toList();
    final othersPercentage = items.length > 4
        ? items.skip(4).fold(0.0, (sum, item) => sum + item.percentage)
        : 0.0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
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
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Pie Chart
              Expanded(
                flex: 1,
                child: _buildPieChart(topItems, othersPercentage),
              ),
              const SizedBox(width: 16),
              // Legend
              Expanded(
                flex: 1,
                child: _buildLegend(topItems, othersPercentage),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPieChart(List<ProjectItem> items, double othersPercentage) {
    return SizedBox(
      height: 150,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(140, 140),
            painter: PieChartPainter(items: items, othersPercentage: othersPercentage),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${items.isNotEmpty ? items.first.percentage.toStringAsFixed(0) : '0'}%',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              const Text(
                'Total',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegend(List<ProjectItem> items, double othersPercentage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: _getColorForIndex(items.indexOf(item)),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                '${item.percentage.toStringAsFixed(0)}%',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        )),
        if (othersPercentage > 0)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Others',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  '${othersPercentage.toStringAsFixed(0)}%',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Color _getColorForIndex(int index) {
    const colors = [
      Color(0xFF3B82F6), // Blue
      Color(0xFF10B981), // Green
      Color(0xFFF59E0B), // Orange
      Color(0xFFEF4444), // Red
    ];
    return colors[index % colors.length];
  }

  List<Department> _getDefaultDepartments() {
    return [
      const Department(name: 'ENN_CIRQ', count: 45, percentage: 9),
      const Department(name: 'NTGU_IMDV', count: 30, percentage: 6),
      const Department(name: 'CLUD_FREE', count: 30, percentage: 6),
      const Department(name: 'EQUIL_IMSS', count: 30, percentage: 6),
      const Department(name: 'Others', count: 365, percentage: 73),
    ];
  }
}

class ProjectItem {
  final String name;
  final double percentage;
  final int count;

  ProjectItem({
    required this.name,
    required this.percentage,
    required this.count,
  });
}

class PieChartPainter extends CustomPainter {
  final List<ProjectItem> items;
  final double othersPercentage;

  PieChartPainter({
    required this.items,
    required this.othersPercentage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final total = items.fold(0.0, (sum, item) => sum + item.percentage) + othersPercentage;
    var startAngle = -90.0; // Start from top

    // Draw slices for top items
    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      final sweepAngle = (item.percentage / total) * 360;
      final paint = Paint()
        ..color = _getColorForIndex(i)
        ..style = PaintingStyle.fill;

      canvas.drawArc(
        rect,
        startAngle * (3.14159 / 180),
        sweepAngle * (3.14159 / 180),
        true,
        paint,
      );
      startAngle += sweepAngle;
    }

    // Draw "Others" slice if exists
    if (othersPercentage > 0) {
      final sweepAngle = (othersPercentage / total) * 360;
      final paint = Paint()
        ..color = Colors.grey.shade400
        ..style = PaintingStyle.fill;

      canvas.drawArc(
        rect,
        startAngle * (3.14159 / 180),
        sweepAngle * (3.14159 / 180),
        true,
        paint,
      );
    }
  }

  Color _getColorForIndex(int index) {
    const colors = [
      Color(0xFF3B82F6), // Blue
      Color(0xFF10B981), // Green
      Color(0xFFF59E0B), // Orange
      Color(0xFFEF4444), // Red
    ];
    return colors[index % colors.length];
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}