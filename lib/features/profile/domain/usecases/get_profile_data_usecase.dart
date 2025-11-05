import 'package:injectable/injectable.dart';
import '../../../../core/errors/api_result.dart';
import '../entity/user_entity.dart';
import '../repositories/profile_repository.dart';

@injectable
class GetProfileDataUseCase {
  final ProfileRepository _profileRepo;

  GetProfileDataUseCase(this._profileRepo);

  Future<ApiResult<UserEntity>> call() async {
    ApiResult<UserEntity> user = await _profileRepo.getProfile();
    return user;
  }
}
