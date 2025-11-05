import '../../../../core/errors/api_result.dart';
import '../entity/user_entity.dart';

abstract class ProfileRepository {
  Future<ApiResult<UserEntity>> getProfile();
}
