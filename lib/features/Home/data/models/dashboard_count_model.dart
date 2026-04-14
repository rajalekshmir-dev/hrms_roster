class DashboardCountModel {
  final int freepoolCount;
  final int projectCount;
  final int employeeCount;

  DashboardCountModel({
    required this.freepoolCount,
    required this.projectCount,
    required this.employeeCount,
  });

  factory DashboardCountModel.fromJson(Map<String, dynamic> json) {
    return DashboardCountModel(
      freepoolCount: json['freepool_count'] ?? 0,
      projectCount: json['project_count'] ?? 0,
      employeeCount: json['employee_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'freepool_count': freepoolCount,
      'project_count': projectCount,
      'employee_count': employeeCount,
    };
  }
}