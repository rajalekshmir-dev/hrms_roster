import '../../data_sources/remote/users_info_remote.dart';
import '../../domain/repository/users_info_repositories.dart';
import '../model/user_info_model.dart';

class UserInfoRepositoryImpl implements UserInfoRepository {
  final UserInfoRemoteDataSource remoteDataSource;

  UserInfoRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserInfoModel> getUserInfo() async {
    return await remoteDataSource.fetchUserInfo();
  }
}
