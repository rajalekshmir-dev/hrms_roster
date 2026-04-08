import 'package:equatable/equatable.dart';
import 'package:hrms_roster/features/search_info/domain/entities/project_entities.dart';

import 'ai_critirea_entities.dart';

class EmployeeDataEntity extends Equatable {
  final String? employeeId;
  final String? displayName;
  final String? designation;
  final String? location;
  final int? aiScore;
  final String? aiReason;

  final List<ProjectEntity> projects;

  final AiCriteriaEntity? aiCriteria;

  const EmployeeDataEntity({
    this.employeeId,
    this.displayName,
    this.designation,
    this.location,
    this.aiScore,
    this.aiReason,
    required this.projects,
    this.aiCriteria,
  });

  @override
  List<Object?> get props => [
    employeeId,
    displayName,
    designation,
    location,
    aiScore,
    aiReason,
    projects,
    aiCriteria,
  ];
}
