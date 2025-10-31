import '../models/difficulty_levels_response.dart';
import '../models/get_exercise_by_muscle_and_difficulty.dart';

abstract class ExerciseRemoteDatasource {
  Future<DifficultyLevelResponse> getAllDifficultyLevels(
    String primeMoverMuscleId,
  );
  Future<GetExerciseByMuscleAndDifficulty> getExerciseByMuscleAndDifficulty(
    String primeMoverMuscleId,
    String difficultyLevelId,
  );
}
