import 'package:equatable/equatable.dart';

class Employee extends Equatable {
  final String? employeeId;
  final String? displayName;
  final String? employeeDepartment;
  final String? designation;
  final String? techGroup;
  final String? empLocation;

  const Employee({
    this.employeeId,
    this.displayName,
    this.employeeDepartment,
    this.designation,
    this.techGroup,
    this.empLocation,
  });

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
