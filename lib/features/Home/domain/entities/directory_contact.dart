class DirectoryContact {
  final String name;
  final String title;
  final String location;
  final String? email;
  final String? phone;
  final String? avatar;
  final String? id;
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

  const DirectoryContact({
    required this.name,
    required this.title,
    required this.location,
    this.email,
    this.phone,
    this.avatar,
    this.id,
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
  });
}

class ProjectDetail {
  final String name;
  final String? projectManager;
  final String? customer;
  final String? role;
  final int? occupancy;
  final String? status;

  const ProjectDetail({
    required this.name,
    this.projectManager,
    this.customer,
    this.role,
    this.occupancy,
    this.status,
  });
}
