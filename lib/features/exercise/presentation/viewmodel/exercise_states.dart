abstract class ExerciseState {}

class ExerciseInitial extends ExerciseState {}

class GetLevelsLoading extends ExerciseState {}

class GetLevelsSuccess extends ExerciseState {
  final dynamic difficultyLevelResponse;
  final String? selectedDifficultyId;

  GetLevelsSuccess({
    required this.difficultyLevelResponse,
    this.selectedDifficultyId,
  });
}

class GetLevelsError extends ExerciseState {
  final String message;
  GetLevelsError({required this.message});
}

class ExerciseLoading extends ExerciseState {}

class ExerciseDataLoaded extends ExerciseState {
  final dynamic exercises;
  final dynamic difficultyLevels;
  final String? selectedDifficultyId;

  ExerciseDataLoaded({
    required this.exercises,
    required this.difficultyLevels,
    required this.selectedDifficultyId,
  });
}

class ExerciseError extends ExerciseState {
  final String message;
  ExerciseError({required this.message});
}
