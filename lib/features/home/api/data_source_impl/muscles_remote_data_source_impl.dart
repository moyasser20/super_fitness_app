import 'package:injectable/injectable.dart';
import '../../../../core/api/client/api_client.dart';
import '../../data/data_source/muscles_remote_data_source.dart';
import '../../data/models/muscle_group_by_id_response_model.dart';
import '../../data/models/muscle_groups_response_model.dart';
import '../../data/models/muscles_response_model.dart';

@LazySingleton(as: MusclesRemoteDatasource)
class MusclesRemoteDatasourceImpl implements MusclesRemoteDatasource {
  final ApiClient _apiClient;

  MusclesRemoteDatasourceImpl(this._apiClient);

  @override
  Future<MusclesResponse> getRandomMuscles() async {
    try {
      return await _apiClient.getRandomMuscles();
    } catch (e) {
      throw Exception('Failed to load muscles: $e');
    }
  }

  @override
  Future<MuscleGroupsResponse> getMuscleGroups() async {
    try {
      return await _apiClient.getMuscleGroups();
    } catch (e) {
      throw Exception('Failed to load muscle groups: $e');
    }
  }

  @override
  Future<MuscleGroupByIdResponse> getMuscleGroupById(String groupId) async {
    try {
      return await _apiClient.getMuscleGroupById(groupId);
    } catch (e) {
      throw Exception('Failed to load muscle group by id: $e');
    }
  }
}
