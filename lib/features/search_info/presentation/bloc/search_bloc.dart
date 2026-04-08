import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms_roster/features/search_info/presentation/bloc/search_event.dart';
import 'package:hrms_roster/features/search_info/presentation/bloc/search_state.dart';

import '../../domain/repositories/search_repositories.dart';

class EmployeeSearchBloc
    extends Bloc<EmployeeSearchEvent, EmployeeSearchState> {
  final EmployeeRepository repository;

  EmployeeSearchBloc(this.repository) : super(EmployeeInitial()) {
    on<SearchEmployeeEvent>((event, emit) async {
      emit(EmployeeLoading());

      try {
        final result = await repository.searchEmployees(event.query);

        emit(EmployeeLoaded(result));
      } catch (e) {
        emit(EmployeeError(e.toString()));
      }
    });
  }
}
