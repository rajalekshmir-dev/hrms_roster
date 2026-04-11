import '../../data/model/user_info_model.dart';

abstract class UserInfoRepository {
  Future<UserInfoModel> getUserInfo();
}
