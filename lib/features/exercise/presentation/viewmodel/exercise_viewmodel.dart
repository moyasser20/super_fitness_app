import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../data/models/difficulty_levels.dart';
import '../../domain/use_cases/get_all_difficulty_levels_usecase.dart';
import '../../domain/use_cases/get_exercise_by_muscle_and_difficulty_usecase.dart';
import 'exercise_states.dart';

@injectable
class ExerciseViewModel extends Cubit<ExerciseState> {
  final GetAllDifficultyLevelsUseCase getAllDifficultyLevelsUseCase;
  final GetExerciseByMuscleAndDifficultyUseCase getExerciseByMuscleAndDifficultyUseCase;

  dynamic difficultyLevelResponse;
  String? selectedDifficultyId;

  ExerciseViewModel({
    required this.getAllDifficultyLevelsUseCase,
    required this.getExerciseByMuscleAndDifficultyUseCase,
  }) : super(ExerciseInitial());

  Future<void> getAllDifficultyLevels(String primeMoverMuscleId) async {
    emit(GetLevelsLoading());
    try {
      final result = await getAllDifficultyLevelsUseCase(primeMoverMuscleId);
      difficultyLevelResponse = result;

      if (result.difficultyLevels != null && result.difficultyLevels!.isNotEmpty) {
        selectedDifficultyId = result.difficultyLevels!.first.id;

        emit(GetLevelsSuccess(
          difficultyLevelResponse: result,
          selectedDifficultyId: selectedDifficultyId,
        ));

        await getExerciseByMuscleAndDifficulty(
          primeMoverMuscleId,
          selectedDifficultyId!,
          difficultyLevels: result.difficultyLevels!,
        );
      } else {
        emit(GetLevelsSuccess(difficultyLevelResponse: result));
      }
    } catch (e) {
      emit(GetLevelsError(message: e.toString()));
    }
  }

  Future<void> getExerciseByMuscleAndDifficulty(
      String muscleId,
      String difficultyId, {
        required List<DifficultyLevels> difficultyLevels,
      }) async {
    try {
      emit(ExerciseLoading());
      selectedDifficultyId = difficultyId;

      final exercises = await getExerciseByMuscleAndDifficultyUseCase(
        muscleId,
        difficultyId,
      );

      emit(ExerciseDataLoaded(
        exercises: exercises,
        difficultyLevels: difficultyLevels,
        selectedDifficultyId: difficultyId,
      ));
    } catch (e) {
      emit(ExerciseError(message: e.toString()));
    }
  }

  String extractYouTubeId(String url) {
    final uri = Uri.parse(url);

    if (uri.host.contains('youtu.be')) {
      return uri.pathSegments.isNotEmpty ? uri.pathSegments.first : '';
    } else if (uri.host.contains('youtube.com')) {
      return uri.queryParameters['v'] ?? '';
    }
    return '';
  }

  String getYouTubeThumbnail(String videoUrl) {
    final videoId = extractYouTubeId(videoUrl);
    return "https://img.youtube.com/vi/$videoId/hqdefault.jpg";
  }
}

class ExerciseData{
  final String id;
  final String name;

  ExerciseData({required this.id, required this.name});
}
