import '../../data/model/user_info_model.dart';

abstract class UserInfoState {}

class UserInfoLoading extends UserInfoState {}

class UserInfoLoaded extends UserInfoState {
  final List<User> users;

  UserInfoLoaded(this.users);
}

class UserInfoError extends UserInfoState {
  final String message;

  UserInfoError(this.message);
}
