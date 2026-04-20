import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/user_info_model.dart';
import '../../domain/repository/users_info_repositories.dart';
import 'users_info_event.dart';
import 'users_info_state.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  final UserInfoRepository repository;

  List<Employeess> allUsers = [];
  List<Employeess> filteredUsers = [];

  UserInfoBloc(this.repository) : super(UserInfoLoading()) {
    on<FetchUserInfo>(_fetchUsers);
    on<SearchUsers>(_searchUsers);
    on<AddSkill>((event, emit) async {
      try {
        await repository.addSkill(event.employeeId, event.skill);

        add(FetchUserInfo()); // refresh employee list
      } catch (e) {
        emit(UserInfoError(e.toString()));
      }
    });
  }

  Future<void> _fetchUsers(
    FetchUserInfo event,
    Emitter<UserInfoState> emit,
  ) async {
    emit(UserInfoLoading());

    try {
      final result = await repository.getUserInfo();

      allUsers = result.employees ?? [];
      filteredUsers = List.from(allUsers);

      emit(UserInfoLoaded(filteredUsers));
    } catch (e) {
      emit(UserInfoError(e.toString()));
    }
  }

  void _searchUsers(SearchUsers event, Emitter<UserInfoState> emit) {
    final query = event.query.toLowerCase().trim();

    if (query.isEmpty) {
      filteredUsers = List.from(allUsers);
    } else {
      filteredUsers = allUsers.where((user) {
        final name = user.displayName?.toLowerCase() ?? '';
        final designation = user.designation?.toLowerCase() ?? '';
        final skills = user.skillSet?.toLowerCase() ?? '';

        return name.contains(query) ||
            designation.contains(query) ||
            skills.contains(query);
      }).toList();
    }

    emit(UserInfoLoaded(filteredUsers));
  }
}
