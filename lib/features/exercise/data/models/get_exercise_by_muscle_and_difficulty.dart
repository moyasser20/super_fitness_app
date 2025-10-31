import 'package:json_annotation/json_annotation.dart';

import 'exercises.dart';

part 'get_exercise_by_muscle_and_difficulty.g.dart';

@JsonSerializable()
class GetExerciseByMuscleAndDifficulty {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "totalExercises")
  final int? totalExercises;
  @JsonKey(name: "totalPages")
  final int? totalPages;
  @JsonKey(name: "currentPage")
  final int? currentPage;
  @JsonKey(name: "exercises")
  final List<Exercises> exercises;

  GetExerciseByMuscleAndDifficulty ({
    this.message,
    this.totalExercises,
    this.totalPages,
    this.currentPage,
    required this.exercises,
  });

  factory GetExerciseByMuscleAndDifficulty.fromJson(Map<String, dynamic> json) {
    return _$GetExerciseByMuscleAndDifficultyFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GetExerciseByMuscleAndDifficultyToJson(this);
  }
}




