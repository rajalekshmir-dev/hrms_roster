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

  const EmployeeLoaded(this.employee);

  @override
  List<Object?> get props => [employee];
}

class EmployeeError extends EmployeeSearchState {
  final String message;

  const EmployeeError(this.message);

  @override
  List<Object?> get props => [message];
}
