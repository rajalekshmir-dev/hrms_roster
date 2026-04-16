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

  /// CURRENT FILTERS
  String? selectedDepartment;
  String? selectedLocation;
  String? selectedExperience;
  List<String>? selectedTechGroups;

  EmployeeSearchBloc(this.repository) : super(EmployeeInitial()) {
    /// SEARCH EVENT
    on<SearchEmployeeEvent>((event, emit) async {
      emit(EmployeeLoading());

      final result = await repository.searchEmployees(event.query);

      /// RESET FILTER STATE
      selectedDepartment = null;
      selectedLocation = null;
      selectedExperience = null;
      selectedTechGroups = null;

      /// UPDATE DATA
      allEmployees = result.data;
      filteredEmployees = List.from(allEmployees);

      emit(
        EmployeeLoaded(
          EmployeeModel(
            action: result.action,
            ranking: result.ranking,
            response: result.response,
            data: filteredEmployees,
            totalResults: filteredEmployees.length,
            parsedQuery: result.parsedQuery,
            processingTime: result.processingTime,
            employeeSearch: result.employeeSearch,
          ),
          extractSkills(allEmployees),
          extractTechGroups(allEmployees),
          extractLocations(allEmployees),
          extractExperiences(allEmployees),
          extractDepartment(allEmployees),
        ),
      );
    });

    /// FILTER EVENT
    on<FilterEmployeesEvent>((event, emit) {
      /// SAVE SELECTED FILTERS
      selectedDepartment = event.department;
      selectedLocation = event.location;
      selectedExperience = event.experience;
      selectedTechGroups = event.techGroups;

      filteredEmployees = allEmployees.where((emp) {
        if (selectedDepartment != null &&
            emp.employeeDepartment?.trim() != selectedDepartment?.trim()) {
          return false;
        }

        if (selectedLocation != null &&
            !(emp.empLocation ?? "").toLowerCase().contains(
              selectedLocation!.toLowerCase(),
            )) {
          return false;
        }

        if (selectedExperience != null &&
            emp.totalExp?.trim() != selectedExperience?.trim()) {
          return false;
        }

        if (selectedTechGroups != null &&
            !selectedTechGroups!.contains(emp.techGroup?.trim())) {
          return false;
        }
        if (selectedDepartment != null &&
            !(emp.employeeDepartment ?? "").toLowerCase().contains(
              selectedDepartment!.toLowerCase(),
            )) {
          return false;
        }

        /// SKILLS FILTER
        if (selectedTechGroups != null &&
            !selectedTechGroups!.contains(emp.techGroup)) {
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
          extractDepartment(allEmployees), // ✅ fixed
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
    return employees.map((e) => (e.techGroup ?? "").trim()).toSet().toList()
      ..sort();
  }

  /// LOCATION
  List<String> extractLocations(List<Datum> employees) {
    return employees.map((e) => (e.empLocation ?? "").trim()).toSet().toList()
      ..sort();
  }

  /// EXPERIENCE
  List<String> extractExperiences(List<Datum> employees) {
    return employees.map((e) => (e.totalExp ?? "").trim()).toSet().toList()
      ..sort();
  }

  /// DEPARTMENT
  List<String> extractDepartment(List<Datum> employees) {
    return employees
        .map((e) => (e.employeeDepartment ?? "").trim())
        .toSet()
        .toList()
      ..sort();
  }
}
