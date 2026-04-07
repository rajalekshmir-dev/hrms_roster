class EmployeeModel {
  final String id;
  final String name;
  final String designation;
  final String department;
  final String location;
  final String techGroup;
  final String totalExp;
  final List<String> skills;
  final String projectName;
  final int occupancy;

  EmployeeModel({
    required this.id,
    required this.name,
    required this.designation,
    required this.department,
    required this.location,
    required this.techGroup,
    required this.totalExp,
    required this.skills,
    required this.projectName,
    required this.occupancy,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    final project = (json["projects"] as List).isNotEmpty
        ? json["projects"][0]
        : null;

    return EmployeeModel(
      id: json["employee_id"],
      name: json["display_name"],
      designation: json["designation"],
      department: json["employee_department"],
      location: json["emp_location"],
      techGroup: json["tech_group"],
      totalExp: json["total_exp"],
      skills: (json["skill_set"] as String)
          .split(',')
          .map((e) => e.trim())
          .toList(),
      projectName: project?["project_name"] ?? "",
      occupancy: project?["occupancy"] ?? 0,
    );
  }
}
