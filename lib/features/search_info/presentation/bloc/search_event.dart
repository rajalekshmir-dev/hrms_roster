import 'package:equatable/equatable.dart';

abstract class EmployeeSearchEvent extends Equatable {
  const EmployeeSearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchEmployeeEvent extends EmployeeSearchEvent {
  final String query;

  const SearchEmployeeEvent(this.query);

  @override
  List<Object?> get props => [query];
}
