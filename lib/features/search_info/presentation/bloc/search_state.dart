import 'package:equatable/equatable.dart';

import '../../data/models/search_info_model.dart';

abstract class EmployeeSearchState extends Equatable {
  const EmployeeSearchState();

  @override
  List<Object?> get props => [];
}

class EmployeeInitial extends EmployeeSearchState {}

class EmployeeLoading extends EmployeeSearchState {}

class EmployeeLoaded extends EmployeeSearchState {
  final EmployeeModel employee;
  final List<String> skills;
  final List<String> techGroups;
  final List<String> locations;
  final List<String> experiences;
  final List<String> department;

  const EmployeeLoaded(
    this.employee,
    this.skills,
    this.techGroups,
    this.locations,
    this.experiences,
    this.department,
  );

  @override
  List<Object?> get props => [
    employee,
    skills,
    techGroups,
    locations,
    experiences,
  ];
}

class EmployeeError extends EmployeeSearchState {
  final String message;

  const EmployeeError(this.message);

  @override
  List<Object?> get props => [message];
}
