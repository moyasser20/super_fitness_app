import 'package:injectable/injectable.dart';
import '../../data/models/difficulty_levels_response.dart';
import '../repositories/exercise_repo.dart';

@lazySingleton
class GetAllDifficultyLevelsUseCase{
  final ExerciseRepo _exerciseRepo;

  GetAllDifficultyLevelsUseCase(this._exerciseRepo);

  Future<DifficultyLevelResponse> call(String primeMoverMuscleId) async {
    return await _exerciseRepo.getAllDifficultyLevels(primeMoverMuscleId);
  }
}