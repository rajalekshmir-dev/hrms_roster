import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms_roster/features/Home/domain/entities/department.dart';
import 'package:hrms_roster/features/Home/domain/usecases/get_department_stats.dart';
import 'package:hrms_roster/features/Home/domain/usecases/get_employee_directory_usecase.dart';
import 'home_event.dart';
import 'home_state.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetEmployeeDirectory getEmployeeDirectory;
  final GetDepartmentStats getDepartmentStats;
  
  HomeBloc({
    required this.getEmployeeDirectory,
    required this.getDepartmentStats,
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
    final employeesResult = await getEmployeeDirectory();
    final departmentsResult = await getDepartmentStats();
    
    employeesResult.fold(
      (failure) => emit(state.copyWith(
        status: HomeStatus.error,
        errorMessage: failure.message,
      )),
      (employees) {
        departmentsResult.fold(
          (failure) => emit(state.copyWith(
            status: HomeStatus.error,
            errorMessage: failure.message,
          )),
          (departments) {
            // Calculate department percentages based on total employees
            final totalEmployees = employees.length;
            final departmentsWithPercentages = departments.map((dept) {
              final percentage = totalEmployees > 0 
                  ? (dept.count / totalEmployees) * 100 
                  : 0.0;
              return Department(
                name: dept.name,
                count: dept.count,
                id: dept.id,
                percentage: percentage,
              );
            }).toList();
            
            emit(state.copyWith(
              status: HomeStatus.loaded,
              directoryContacts: employees,
              departments: departmentsWithPercentages,
              totalEmployees: totalEmployees,
              errorMessage: null,
            ));
          },
        );
      },
    );
  }
  
  void _onSearchEmployees(
    SearchEmployees event,
    Emitter<HomeState> emit,
  ) {
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
    
    emit(state.copyWith(
      filteredContacts: filtered,
      searchQuery: query,
    ));
  }
  
  void _onClearSearch(
    ClearSearch event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(
      searchQuery: '',
      filteredContacts: [],
    ));
  }
}