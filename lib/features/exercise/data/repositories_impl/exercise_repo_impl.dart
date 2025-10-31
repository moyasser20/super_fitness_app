import 'package:injectable/injectable.dart';
import '../../domain/repositories/exercise_repo.dart';
import '../datasource/exercise_remote_datasource.dart';
import '../models/difficulty_levels_response.dart';
import '../models/get_exercise_by_muscle_and_difficulty.dart';

@Injectable(as: ExerciseRepo)
class ExerciseRepoImpl implements ExerciseRepo {
  final ExerciseRemoteDatasource _exerciseRemoteDatasource;

  ExerciseRepoImpl(this._exerciseRemoteDatasource);

  @override
  Future<DifficultyLevelResponse> getAllDifficultyLevels(
    String primeMoverMuscleId,
  ) async {
    return await _exerciseRemoteDatasource.getAllDifficultyLevels(
      primeMoverMuscleId,
    );
  }

  @override
  Future<GetExerciseByMuscleAndDifficulty> getExerciseByMuscleAndDifficulty(
    String primeMoverMuscleId,
    String difficultyLevelId,
  ) async {
    return await _exerciseRemoteDatasource.getExerciseByMuscleAndDifficulty(
      primeMoverMuscleId,
      difficultyLevelId,
    );
  }
}
