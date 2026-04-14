import 'package:equatable/equatable.dart';
import 'package:hrms_roster/features/Home/domain/entities/directory_contact.dart';

enum HomeStatus { initial, loading, loaded, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<DirectoryContact> directoryContacts;
  final List<DirectoryContact> filteredContacts;
  final String searchQuery;
  final String? errorMessage;
  final int totalEmployees;
  final int freePoolCount;
  final int activeProjects;
  final bool hasMoreData;
  final int currentPage;
  final int totalPages;
  final bool isLoadingMore;

  const HomeState({
    this.status = HomeStatus.initial,
    this.directoryContacts = const [],
    this.filteredContacts = const [],
    this.searchQuery = '',
    this.errorMessage,
    this.totalEmployees = 0,
    this.freePoolCount = 0,
    this.activeProjects = 0,
    this.hasMoreData = true,
    this.currentPage = 1,
    this.totalPages = 1,
    this.isLoadingMore = false,
  });

  HomeState copyWith({
    HomeStatus? status,
    List<DirectoryContact>? directoryContacts,
    List<DirectoryContact>? filteredContacts,
    String? searchQuery,
    String? errorMessage,
    int? totalEmployees,
    int? freePoolCount,
    int? activeProjects,
    bool? hasMoreData,
    int? currentPage,
    int? totalPages,
    bool? isLoadingMore,
  }) {
    return HomeState(
      status: status ?? this.status,
      directoryContacts: directoryContacts ?? this.directoryContacts,
      filteredContacts: filteredContacts ?? this.filteredContacts,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage ?? this.errorMessage,
      totalEmployees: totalEmployees ?? this.totalEmployees,
      freePoolCount: freePoolCount ?? this.freePoolCount,
      activeProjects: activeProjects ?? this.activeProjects,
      hasMoreData: hasMoreData ?? this.hasMoreData,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  List<DirectoryContact> get displayContacts {
    return searchQuery.isNotEmpty ? filteredContacts : directoryContacts;
  }

  bool get hasData => displayContacts.isNotEmpty;
  bool get isEmpty => !hasData && status == HomeStatus.loaded;

  @override
  List<Object?> get props => [
    status,
    directoryContacts,
    filteredContacts,
    searchQuery,
    errorMessage,
    totalEmployees,
    freePoolCount,
    activeProjects,
    hasMoreData,
    currentPage,
    totalPages,
    isLoadingMore,
  ];
}