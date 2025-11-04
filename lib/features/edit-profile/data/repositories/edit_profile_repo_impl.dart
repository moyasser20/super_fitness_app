import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/features/edit-profile/data/data_sources/edit_profile_remote_data_source.dart';
import 'package:super_fitness_app/features/edit-profile/data/models/edit_profile_request.dart';
import 'package:super_fitness_app/features/edit-profile/data/models/edit_profile_response.dart';

@lazySingleton
class EditProfileRepository {
  final EditProfileRemoteDataSource _remoteDataSource;

  EditProfileRepository(this._remoteDataSource);

  Future<EditProfileResponse> editProfile(EditProfileRequest model) async {
    return await _remoteDataSource.editProfile(model);
  }
}
