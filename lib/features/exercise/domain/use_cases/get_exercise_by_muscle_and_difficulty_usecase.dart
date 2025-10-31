import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/features/exercise/domain/repositories/exercise_repo.dart';
import '../../data/models/get_exercise_by_muscle_and_difficulty.dart';

@lazySingleton
class GetExerciseByMuscleAndDifficultyUseCase {
  final ExerciseRepo _exerciseRepo;

  GetExerciseByMuscleAndDifficultyUseCase(this._exerciseRepo);

  Future<GetExerciseByMuscleAndDifficulty> call(
    String primeMoverMuscleId,
    String difficultyLevelId,
  ) async {
    return await _exerciseRepo.getExerciseByMuscleAndDifficulty(
      primeMoverMuscleId,
      difficultyLevelId,
    );
  }
}
