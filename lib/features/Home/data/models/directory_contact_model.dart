import '../../domain/entities/directory_contact.dart';

class DirectoryContactModel extends DirectoryContact {
  const DirectoryContactModel({
    required super.name,
    required super.title,
    required super.location,
    super.email,
    super.phone,
    super.avatar,
    super.id,
    super.department,
    super.occupancyPercent,
    super.employeeId,
    super.techGroup,
    super.totalExp,
    super.vvdnExp,
    super.rmId,
    super.rmName,
    super.employeeOuType,
    super.subDepartment,
    super.skillSet,
    super.skills,
    super.currentProjects,
    super.createdDate,
  });

  // Factory method for directory list endpoint
  factory DirectoryContactModel.fromJson(Map<String, dynamic> json) {
    // Map the API response fields correctly for the directory list
    final name =
        json['display_name'] ??
        json['name'] ??
        json['full_name'] ??
        json['employee_name'] ??
        '';

    final title =
        json['designation'] ??
        json['title'] ??
        json['position'] ??
        json['role'] ??
        '';

    final location =
        json['emp_location'] ??
        json['location'] ??
        json['office_location'] ??
        json['branch'] ??
        json['city'] ??
        '';

    final department =
        json['employee_department'] ?? json['department'] ?? json['dept'] ?? '';

    // Get the employee_id (e.g., "VVDN/413")
    final employeeId = json['employee_id']?.toString();

    // For the id field, also store the employee_id
    String? id;
    if (employeeId != null) {
      id = employeeId;
    }

    return DirectoryContactModel(
      name: name,
      title: title,
      location: location,
      email: json['email'] ?? json['work_email'],
      phone: json['phone'] ?? json['mobile'],
      avatar: json['avatar'] ?? json['profile_pic'],
      id: id,
      department: department,
      occupancyPercent:
          json['occupancy_percent'] ?? json['occupancyPercent'] ?? 0,
      employeeId: employeeId, // Store the full ID like "VVDN/413"
      techGroup: json['tech_group'],
      totalExp: json['total_exp'],
      vvdnExp: json['vvdn_exp'],
      rmId: json['rm_id'],
      rmName: json['rm_name'],
      employeeOuType: json['employee_ou_type'],
      subDepartment: json['sub_department'],
      skillSet: json['skill_set'],
      createdDate: json['created_at'],
    );
  }

  // Factory method for employee details endpoint
  factory DirectoryContactModel.fromEmployeeDetailsJson(
    Map<String, dynamic> json,
  ) {
    // Parse projects
    List<ProjectDetail> projects = [];
    if (json.containsKey('projects') && json['projects'] is List) {
      projects = (json['projects'] as List)
          .map(
            (project) => ProjectDetail(
              name: project['project_name'] ?? '',
              projectManager: project['pm'] ?? '',
              customer: project['customer'] ?? '',
              role: project['role'] ?? '',
              occupancy: project['occupancy'] ?? 0,
              status: project['project_status'] ?? '',
            ),
          )
          .toList();
    }

    // Parse skills from skill_set string
    List<String> skills = [];
    if (json['skill_set'] != null && json['skill_set'].toString().isNotEmpty) {
      skills = json['skill_set']
          .toString()
          .split(',')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();
    }

    return DirectoryContactModel(
      name: json['display_name'] ?? '',
      title: json['designation'] ?? '',
      location: json['emp_location'] ?? '',
      email: json['email'],
      phone: json['phone'],
      employeeId: json['employee_id'],
      department: json['employee_department'],
      techGroup: json['tech_group'],
      totalExp: json['total_exp'],
      vvdnExp: json['vvdn_exp'],
      rmId: json['rm_id'],
      rmName: json['rm_name'],
      employeeOuType: json['employee_ou_type'],
      subDepartment: json['sub_department'],
      skillSet: json['skill_set'],
      skills: skills,
      currentProjects: projects.isEmpty ? null : projects,
      createdDate: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'title': title,
      'location': location,
      'email': email,
      'phone': phone,
      'avatar': avatar,
      'id': id,
      'department': department,
      'occupancy_percent': occupancyPercent,
      'employee_id': employeeId,
      'tech_group': techGroup,
      'total_exp': totalExp,
      'vvdn_exp': vvdnExp,
      'rm_id': rmId,
      'rm_name': rmName,
      'employee_ou_type': employeeOuType,
      'sub_department': subDepartment,
      'skill_set': skillSet,
      'created_at': createdDate,
    };
  }
}
