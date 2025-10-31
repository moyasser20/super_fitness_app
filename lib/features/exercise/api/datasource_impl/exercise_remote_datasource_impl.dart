import 'package:injectable/injectable.dart';
import '../../../../core/api/client/api_client.dart';
import '../../data/datasource/exercise_remote_datasource.dart';
import '../../data/models/difficulty_levels_response.dart';
import '../../data/models/get_exercise_by_muscle_and_difficulty.dart';


@LazySingleton(as: ExerciseRemoteDatasource)
class ExerciseRemoteDatasourceImpl implements ExerciseRemoteDatasource {
  final ApiClient _apiClient;

  ExerciseRemoteDatasourceImpl(this._apiClient);

  @override
  Future<DifficultyLevelResponse> getAllDifficultyLevels(String primeMoverMuscleId) async {
    try {
      return await _apiClient.getAllDifficultyLevels(primeMoverMuscleId);
    } catch (e) {
      throw Exception('Failed to load difficulty levels: $e');
    }
  }

  @override
  Future<GetExerciseByMuscleAndDifficulty> getExerciseByMuscleAndDifficulty(String primeMoverMuscleId, String difficultyLevelId) async {
    try {
      return await _apiClient.getExerciseByMuscleAndDifficulty(primeMoverMuscleId, difficultyLevelId);
    } catch (e) {
      throw Exception('Failed to load difficulty levels: $e');
    }
  }

}
