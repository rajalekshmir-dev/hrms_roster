import '../../data_sources/remote/users_info_remote.dart';
import '../../domain/repository/users_info_repositories.dart';
import '../model/user_info_model.dart';

class UserInfoRepositoryImpl implements UserInfoRepository {
  final UserInfoRemoteDataSource remoteDataSource;

  UserInfoRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> addSkill(String employeeId, String skill) {
    return remoteDataSource.addSkill(employeeId, skill);
  }

  Future<UserInfoModel> getUserInfo() async {
    return await remoteDataSource.fetchUserInfo();
  }
}
