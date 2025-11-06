import 'package:super_fitness_app/features/exercise/data/models/get_exercise_by_muscle_and_difficulty.dart';

import '../../data/models/difficulty_levels_response.dart';

abstract class ExerciseRepo {
  Future<DifficultyLevelResponse> getAllDifficultyLevels(
    String primeMoverMuscleId,
  );
  Future<GetExerciseByMuscleAndDifficulty> getExerciseByMuscleAndDifficulty(
    String primeMoverMuscleId,
    String difficultyLevelId,
  );
}
