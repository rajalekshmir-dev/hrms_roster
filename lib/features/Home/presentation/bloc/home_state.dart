import 'package:equatable/equatable.dart';
import 'package:hrms_roster/features/Home/domain/entities/department.dart';
import 'package:hrms_roster/features/Home/domain/entities/directory_contact.dart';

enum HomeStatus { initial, loading, loaded, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<DirectoryContact> directoryContacts;
  final List<DirectoryContact> filteredContacts;
  final List<Department> departments;
  final String searchQuery;
  final String? errorMessage;
  final int totalEmployees;

  const HomeState({
    this.status = HomeStatus.initial,
    this.directoryContacts = const [],
    this.filteredContacts = const [],
    this.departments = const [],
    this.searchQuery = '',
    this.errorMessage,
    this.totalEmployees = 0,
  });

  HomeState copyWith({
    HomeStatus? status,
    List<DirectoryContact>? directoryContacts,
    List<DirectoryContact>? filteredContacts,
    List<Department>? departments,
    String? searchQuery,
    String? errorMessage,
    int? totalEmployees,
  }) {
    return HomeState(
      status: status ?? this.status,
      directoryContacts: directoryContacts ?? this.directoryContacts,
      filteredContacts: filteredContacts ?? this.filteredContacts,
      departments: departments ?? this.departments,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage ?? this.errorMessage,
      totalEmployees: totalEmployees ?? this.totalEmployees,
    );
  }

  List<DirectoryContact> get displayContacts {
    return searchQuery.isNotEmpty ? filteredContacts : directoryContacts;
  }

  @override
  List<Object?> get props => [
    status,
    directoryContacts,
    filteredContacts,
    departments,
    searchQuery,
    errorMessage,
    totalEmployees,
  ];
}
