abstract class UserInfoEvent {}

class FetchUserInfo extends UserInfoEvent {}

class SearchUsers extends UserInfoEvent {
  final String query;

  SearchUsers(this.query);
}
