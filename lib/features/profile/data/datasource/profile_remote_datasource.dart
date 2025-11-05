import '../../../../core/errors/api_result.dart';
import '../models/profile_response.dart';

abstract class ProfileRemoteDatasource {
  Future<ApiResult<ProfileResponse>> getProfile();
}
