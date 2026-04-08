import 'package:equatable/equatable.dart';
import 'package:hrms_roster/features/search_info/domain/entities/parsed_query_entity.dart';

import 'employee_data_enities.dart';

class EmployeeEntity extends Equatable {
  final String? action;
  final bool? ranking;
  final String? response;
  final List<EmployeeDataEntity> data;
  final int? totalResults;
  final ParsedQueryEntity? parsedQuery;
  final double? processingTime;
  final bool? employeeSearch;

  const EmployeeEntity({
    this.action,
    this.ranking,
    this.response,
    required this.data,
    this.totalResults,
    this.parsedQuery,
    this.processingTime,
    this.employeeSearch,
  });

  @override
  List<Object?> get props => [
    action,
    ranking,
    response,
    data,
    totalResults,
    parsedQuery,
    processingTime,
    employeeSearch,
  ];
}
