import '../../domain/entities/department.dart';

class DepartmentModel extends Department {
  const DepartmentModel({
    required super.name,
    required super.count,
    super.id,
    super.percentage,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      name: json['name'] ?? json['department_name'] ?? '',
      count: json['count'] ?? json['employee_count'] ?? 0,
      id: json['id']?.toString(),
      percentage: json['percentage']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'count': count, 'id': id, 'percentage': percentage};
  }
}
