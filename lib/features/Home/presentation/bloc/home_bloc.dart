import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms_roster/features/Home/domain/entities/directory_contact.dart';
import 'package:hrms_roster/features/Home/domain/usecases/get_dashboard_count.dart';
import 'package:hrms_roster/features/Home/domain/usecases/get_employee_directory_usecase.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetEmployeeDirectory getEmployeeDirectory;
  final GetDashboardCount getDashboardCount;
  
  static const int pageSize = 10; 
  List<DirectoryContact> _allEmployees = []; 
  int _totalEmployeesCount = 0;

  HomeBloc({
    required this.getEmployeeDirectory,
    required this.getDashboardCount,
  }) : super(const HomeState()) {
    on<LoadHomeData>(_onLoadHomeData);
    on<SearchEmployees>(_onSearchEmployees);
    on<ClearSearch>(_onClearSearch);
    on<RefreshHomeData>(_onRefreshHomeData);
    on<GoToPage>(_onGoToPage);
  }

  Future<void> _onLoadHomeData(
    LoadHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));
    await _fetchDashboardCount(emit);
    await _fetchAllEmployees(emit);
  }

  Future<void> _onRefreshHomeData(
    RefreshHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));
    await _fetchDashboardCount(emit);
    await _fetchAllEmployees(emit);
  }

  Future<void> _onGoToPage(
    GoToPage event,
    Emitter<HomeState> emit,
  ) async {
    if (event.page == state.currentPage) return;
    if (event.page < 1 || event.page > state.totalPages) return;
    
    
    final startIndex = (event.page - 1) * pageSize;
    final endIndex = startIndex + pageSize;
    final paginatedEmployees = _allEmployees.length > startIndex
        ? _allEmployees.sublist(
            startIndex,
            endIndex > _allEmployees.length ? _allEmployees.length : endIndex,
          )
        : <DirectoryContact>[];
    
    emit(state.copyWith(
      directoryContacts: paginatedEmployees,
      currentPage: event.page,
      isLoadingMore: false,
    ));
  }

  Future<void> _fetchDashboardCount(Emitter<HomeState> emit) async {
    final dashboardResult = await getDashboardCount();
    dashboardResult.fold(
      (failure) => emit(
        state.copyWith(status: HomeStatus.error, errorMessage: failure.message),
      ),
      (dashboardCount) {
        _totalEmployeesCount = dashboardCount.employeeCount;
        final totalPages = (_totalEmployeesCount / pageSize).ceil();
        emit(state.copyWith(
          totalEmployees: dashboardCount.employeeCount,
          freePoolCount: dashboardCount.freepoolCount,
          activeProjects: dashboardCount.projectCount,
          totalPages: totalPages > 0 ? totalPages : 1,
        ));
      },
    );
  }

  Future<void> _fetchAllEmployees(Emitter<HomeState> emit) async {

    final employeesResult = await getEmployeeDirectory(
      page: 1,
      limit: 1000, 
    );

    employeesResult.fold(
      (failure) => emit(
        state.copyWith(status: HomeStatus.error, errorMessage: failure.message),
      ),
      (employees) {
        _allEmployees = employees;
       
        final startIndex = 0;
        final endIndex = pageSize;
        final paginatedEmployees = employees.length > startIndex
            ? employees.sublist(
                startIndex,
                endIndex > employees.length ? employees.length : endIndex,
              )
            : <DirectoryContact>[];
        
        emit(
          state.copyWith(
            status: HomeStatus.loaded,
            directoryContacts: paginatedEmployees,
            currentPage: 1,
            errorMessage: null,
          ),
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

    final filtered = _allEmployees.where((contact) {
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

  void _onClearSearch(ClearSearch event, Emitter<HomeState> emit) {
  
    final startIndex = (state.currentPage - 1) * pageSize;
    final endIndex = startIndex + pageSize;
    final paginatedEmployees = _allEmployees.length > startIndex
        ? _allEmployees.sublist(
            startIndex,
            endIndex > _allEmployees.length ? _allEmployees.length : endIndex,
          )
        : <DirectoryContact>[];
    
    emit(state.copyWith(
      searchQuery: '',
      filteredContacts: [],
      directoryContacts: paginatedEmployees,
    ));
  }
}