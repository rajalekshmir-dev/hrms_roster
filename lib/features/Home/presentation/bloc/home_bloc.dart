
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms_roster/features/Home/domain/usecases/get_dashboard_count.dart';
import 'package:hrms_roster/features/Home/domain/usecases/get_employee_directory_usecase.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetEmployeeDirectory getEmployeeDirectory;
  final GetDashboardCount getDashboardCount;

  HomeBloc({
    required this.getEmployeeDirectory,
    required this.getDashboardCount,
  }) : super(const HomeState()) {
    on<LoadHomeData>(_onLoadHomeData);
    on<SearchEmployees>(_onSearchEmployees);
    on<ClearSearch>(_onClearSearch);
    on<RefreshHomeData>(_onRefreshHomeData);
  }

  Future<void> _onLoadHomeData(
    LoadHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));
    await _fetchData(emit);
  }

  Future<void> _onRefreshHomeData(
    RefreshHomeData event,
    Emitter<HomeState> emit,
  ) async {
    await _fetchData(emit);
  }

  Future<void> _fetchData(Emitter<HomeState> emit) async {
   
    final results = await Future.wait([
      getEmployeeDirectory(),
      getDashboardCount(),
    ]);

    final employeesResult = results[0] as Either;
    final dashboardResult = results[1] as Either;

    employeesResult.fold(
      (failure) => emit(
        state.copyWith(status: HomeStatus.error, errorMessage: failure.message),
      ),
      (employees) {
        dashboardResult.fold(
          (failure) => emit(
            state.copyWith(
              status: HomeStatus.error,
              errorMessage: failure.message,
            ),
          ),
          (dashboardCount) {
            emit(
              state.copyWith(
                status: HomeStatus.loaded,
                directoryContacts: employees,
                totalEmployees: dashboardCount.employeeCount,
                freePoolCount: dashboardCount.freepoolCount,
                activeProjects: dashboardCount.projectCount,
                errorMessage: null,
              ),
            );
          },
        );
      },
    );
  }

  void _onSearchEmployees(SearchEmployees event, Emitter<HomeState> emit) {
    final query = event.query.trim().toLowerCase();

    if (query.isEmpty) {
      emit(state.copyWith(searchQuery: '', filteredContacts: []));
      return;
    }

    final filtered = state.directoryContacts.where((contact) {
      return contact.name.toLowerCase().contains(query) ||
          contact.title.toLowerCase().contains(query) ||
          contact.location.toLowerCase().contains(query) ||
          (contact.department?.toLowerCase().contains(query) ?? false);
    }).toList();

    emit(state.copyWith(filteredContacts: filtered, searchQuery: query));
  }

  void _onClearSearch(ClearSearch event, Emitter<HomeState> emit) {
    emit(state.copyWith(searchQuery: '', filteredContacts: []));
  }
}