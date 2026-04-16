class DirectoryContact {
  final String name;
  final String title;
  final String location;
  final String? email;
  final String? phone;
  final String? avatar;
  final String? id;
  final String? employeeIdRaw;
  final String? department;
  final int occupancyPercent;
  final String? techGroup;
  final String? employeeId;
  final String? experience;
  final String? reportingManager;
  final String? projectManager;
  final List<ProjectDetail>? currentProjects;
  final List<String>? skills;
  final String? createdDate;
  final String? skillSet;
  final String? totalExp;
  final String? vvdnExp;
  final String? rmId;
  final String? rmName;
  final String? employeeOuType;
  final String? subDepartment;

  const DirectoryContact({
    required this.name,
    required this.title,
    required this.location,
    this.email,
    this.phone,
    this.avatar,
    this.id,
    this.employeeIdRaw,
    this.department,
    this.occupancyPercent = 0,
    this.techGroup,
    this.employeeId,
    this.experience,
    this.reportingManager,
    this.projectManager,
    this.currentProjects,
    this.skills,
    this.createdDate,
    this.skillSet,
    this.totalExp,
    this.vvdnExp,
    this.rmId,
    this.rmName,
    this.employeeOuType,
    this.subDepartment,
  });
}

class ProjectDetail {
  final String name;
  final String? projectManager;
  final String? projectManagerId;  // Make sure this line exists
  final String? customer;
  final String? role;
  final int? occupancy;
  final String? status;

  const ProjectDetail({
    required this.name,
    this.projectManager,
    this.projectManagerId,  // Make sure this line exists
    this.customer,
    this.role,
    this.occupancy,
    this.status,
  });
}