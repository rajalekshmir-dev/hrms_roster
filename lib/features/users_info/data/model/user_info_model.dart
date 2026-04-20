class UserInfoModel {
  int? status;
  int? totalEmployees;
  List<Employeess>? employees;

  UserInfoModel({this.status, this.totalEmployees, this.employees});

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      status: json['status'],
      totalEmployees: json['total_employees'],
      employees: (json['employees'] as List?)
          ?.map((e) => Employeess.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "total_employees": totalEmployees,
      "employees": employees?.map((e) => e.toJson()).toList(),
    };
  }
}

class Employeess {
  String? employeeId;
  String? displayName;
  String? designation;
  String? skillSet;
  String? empLocation;
  String? totalExp;
  String? vvdnExp;
  List<Project>? projects;

  Employeess({
    this.employeeId,
    this.displayName,
    this.designation,
    this.skillSet,
    this.empLocation,
    this.totalExp,
    this.vvdnExp,
    this.projects,
  });

  factory Employeess.fromJson(Map<String, dynamic> json) {
    return Employeess(
      employeeId: json['employee_id'],
      displayName: json['display_name'],
      designation: json['designation'],
      skillSet: json['skill_set'],
      empLocation: json['emp_location'],
      totalExp: json['total_exp'],
      vvdnExp: json['vvdn_exp'],
      projects: (json['projects'] as List?)
          ?.map((e) => Project.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "employee_id": employeeId,
      "display_name": displayName,
      "designation": designation,
      "skill_set": skillSet,
      "emp_location": empLocation,
      "total_exp": totalExp,
      "vvdn_exp": vvdnExp,
      "projects": projects?.map((e) => e.toJson()).toList(),
    };
  }
}

class Project {
  String? pm;
  String? role;
  String? customer;
  int? occupancy;
  String? projectName;
  String? projectStatus;

  Project({
    this.pm,
    this.role,
    this.customer,
    this.occupancy,
    this.projectName,
    this.projectStatus,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      pm: json['pm'],
      role: json['role'],
      customer: json['customer'],
      occupancy: json['occupancy'],
      projectName: json['project_name'],
      projectStatus: json['project_status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "pm": pm,
      "role": role,
      "customer": customer,
      "occupancy": occupancy,
      "project_name": projectName,
      "project_status": projectStatus,
    };
  }
}
