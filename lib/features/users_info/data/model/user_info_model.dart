import 'package:equatable/equatable.dart';

class UserInfoModel extends Equatable {
  UserInfoModel({required this.status, required this.employees});

  final String? status;
  final List<User> employees;

  UserInfoModel copyWith({String? status, List<User>? employees}) {
    return UserInfoModel(
      status: status ?? this.status,
      employees: employees ?? this.employees,
    );
  }

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      status: json["status"],
      employees: json["employees"] == null
          ? []
          : List<User>.from(json["employees"]!.map((x) => User.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "employees": employees.map((x) => x?.toJson()).toList(),
  };

  @override
  String toString() {
    return "$status, $employees, ";
  }

  @override
  List<Object?> get props => [status, employees];
}

class User extends Equatable {
  User({
    required this.employeeId,
    required this.displayName,
    required this.employeeDepartment,
    required this.designation,
    required this.techGroup,
    required this.empLocation,
  });

  final String? employeeId;
  final String? displayName;
  final String? employeeDepartment;
  final String? designation;
  final String? techGroup;
  final String? empLocation;

  User copyWith({
    String? employeeId,
    String? displayName,
    String? employeeDepartment,
    String? designation,
    String? techGroup,
    String? empLocation,
  }) {
    return User(
      employeeId: employeeId ?? this.employeeId,
      displayName: displayName ?? this.displayName,
      employeeDepartment: employeeDepartment ?? this.employeeDepartment,
      designation: designation ?? this.designation,
      techGroup: techGroup ?? this.techGroup,
      empLocation: empLocation ?? this.empLocation,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      employeeId: json["employee_id"],
      displayName: json["display_name"],
      employeeDepartment: json["employee_department"],
      designation: json["designation"],
      techGroup: json["tech_group"],
      empLocation: json["emp_location"],
    );
  }

  Map<String, dynamic> toJson() => {
    "employee_id": employeeId,
    "display_name": displayName,
    "employee_department": employeeDepartment,
    "designation": designation,
    "tech_group": techGroup,
    "emp_location": empLocation,
  };

  @override
  String toString() {
    return "$employeeId, $displayName, $employeeDepartment, $designation, $techGroup, $empLocation, ";
  }

  @override
  List<Object?> get props => [
    employeeId,
    displayName,
    employeeDepartment,
    designation,
    techGroup,
    empLocation,
  ];
}
