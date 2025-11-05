import '../../../../core/errors/api_result.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasource/profile_remote_datasource.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDatasource _remoteDatasource;

  ProfileRepositoryImpl(this._remoteDatasource);

  @override
  Future<ApiResult<UserEntity>> getProfile() async {
    final result = await _remoteDatasource.getProfile();

    return switch (result) {
      ApiSuccessResult(:final data) => ApiSuccessResult(
        UserEntity(
          id: data.user.Id ?? '',
          firstName: data.user.firstName,
          lastName: data.user.lastName,
          email: data.user.email,
          gender: data.user.gender,
          photo: data.user.photo,
          age: data.user.age,
          weight: data.user.weight,
          height: data.user.height,
          activityLevel: data.user.activityLevel,
          goal: data.user.goal,
        ),
      ),
      ApiErrorResult(:final errorMessage) => ApiErrorResult(errorMessage),
    };
  }
}
