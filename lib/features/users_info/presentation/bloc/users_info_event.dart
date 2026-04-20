abstract class UserInfoEvent {}

class FetchUserInfo extends UserInfoEvent {}

class SearchUsers extends UserInfoEvent {
  final String query;

  SearchUsers(this.query);
}

class AddSkill extends UserInfoEvent {
  final String employeeId;
  final String skill;

  AddSkill(this.employeeId, this.skill);
}
