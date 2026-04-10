import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms_roster/features/search_info/presentation/bloc/search_event.dart';
import 'package:hrms_roster/features/search_info/presentation/bloc/search_state.dart';

import '../../data/models/search_info_model.dart';
import '../../domain/repositories/search_repositories.dart';

class EmployeeSearchBloc
    extends Bloc<EmployeeSearchEvent, EmployeeSearchState> {
  final EmployeeRepository repository;

  List<Datum> allEmployees = [];
  List<Datum> filteredEmployees = [];

  EmployeeSearchBloc(this.repository) : super(EmployeeInitial()) {
    on<SearchEmployeeEvent>((event, emit) async {
      emit(EmployeeLoading());

      final result = await repository.searchEmployees(event.query);

      allEmployees = result.data;
      filteredEmployees = allEmployees;

      final skills = extractSkills(allEmployees);
      final techGroups = extractTechGroups(allEmployees);
      final locations = extractLocations(allEmployees);
      final experiences = extractExperiences(allEmployees);
      final department = extractDepartment(allEmployees);

      emit(
        EmployeeLoaded(
          result,
          skills,
          techGroups,
          locations,
          experiences,
          department,
        ),
      );
    });

    on<FilterEmployeesEvent>((event, emit) {
      filteredEmployees = allEmployees.where((emp) {
        if (event.department != null &&
            emp.employeeDepartment != event.department) {
          return false;
        }

        if (event.location != null && emp.empLocation != event.location) {
          return false;
        }

        if (event.techGroups != null &&
            !event.techGroups!.contains(emp.techGroup)) {
          return false;
        }

        return true;
      }).toList();

      final model = EmployeeModel(
        action: "",
        ranking: true,
        response: "",
        data: filteredEmployees,
        totalResults: filteredEmployees.length,
        parsedQuery: null,
        processingTime: 0,
        employeeSearch: true,
      );

      emit(
        EmployeeLoaded(
          model,
          extractSkills(allEmployees),
          extractTechGroups(allEmployees),
          extractLocations(allEmployees),
          extractExperiences(allEmployees),
          extractExperiences(allEmployees),
        ),
      );
    });
  }

  /// SKILLS
  List<String> extractSkills(List<Datum> employees) {
    final skills = <String>{};

    for (var emp in employees) {
      final skillList = (emp.skillSet ?? "").split(",");
      for (var skill in skillList) {
        skills.add(skill.trim());
      }
    }

    return skills.toList()..sort();
  }

  /// TECH GROUP
  List<String> extractTechGroups(List<Datum> employees) {
    return employees.map((e) => e.techGroup ?? "").toSet().toList()..sort();
  }

  /// LOCATION
  List<String> extractLocations(List<Datum> employees) {
    return employees.map((e) => e.empLocation ?? "").toSet().toList()..sort();
  }

  /// EXPERIENCE
  List<String> extractExperiences(List<Datum> employees) {
    return employees.map((e) => e.totalExp ?? "").toSet().toList()..sort();
  }

  /// DEPARTMENT
  List<String> extractDepartment(List<Datum> employees) {
    return employees.map((e) => e.employeeDepartment ?? "").toSet().toList()
      ..sort();
  }
}
