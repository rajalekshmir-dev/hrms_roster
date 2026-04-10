abstract class EmployeeSearchEvent {}

class SearchEmployeeEvent extends EmployeeSearchEvent {
  final String query;

  SearchEmployeeEvent({required this.query});
}

class FilterEmployeesEvent extends EmployeeSearchEvent {
  final String? department;
  final String? experience;
  final String? location;
  final List<String>? techGroups;

  FilterEmployeesEvent({
    this.department,
    this.experience,
    this.location,
    this.techGroups,
  });
}
