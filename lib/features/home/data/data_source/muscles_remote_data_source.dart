import '../models/muscle_group_by_id_response_model.dart';
import '../models/muscle_groups_response_model.dart';
import '../models/muscles_response_model.dart';

abstract class MusclesRemoteDatasource {
  Future<MusclesResponse> getRandomMuscles();
  Future<MuscleGroupsResponse> getMuscleGroups();
  Future<MuscleGroupByIdResponse> getMuscleGroupById(String groupId);
}
