import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms_roster/features/users_info/presentation/bloc/users_info_event.dart';
import 'package:hrms_roster/features/users_info/presentation/bloc/users_info_state.dart';

import '../../data/model/user_info_model.dart';
import '../../domain/repository/users_info_repositories.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  final UserInfoRepository repository;

  List<User> allUsers = [];

  UserInfoBloc(this.repository) : super(UserInfoLoading()) {
    on<FetchUserInfo>(_fetchUsers);
    on<SearchUsers>(_searchUsers);
  }

  Future<void> _fetchUsers(
    FetchUserInfo event,
    Emitter<UserInfoState> emit,
  ) async {
    try {
      final result = await repository.getUserInfo();

      allUsers = result.employees;

      emit(UserInfoLoaded(allUsers));
    } catch (e) {
      emit(UserInfoError(e.toString()));
    }
  }

  void _searchUsers(SearchUsers event, Emitter<UserInfoState> emit) {
    final query = event.query.toLowerCase();

    if (query.isEmpty) {
      emit(UserInfoLoaded(allUsers));
      return;
    }

    final filtered = allUsers.where((user) {
      return user.displayName!.toLowerCase().contains(query) ||
          user.employeeId!.toLowerCase().contains(query) ||
          user.designation!.toLowerCase().contains(query);
    }).toList();

    emit(UserInfoLoaded(filtered));
  }
}
