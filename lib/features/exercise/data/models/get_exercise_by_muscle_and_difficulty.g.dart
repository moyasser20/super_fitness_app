// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_exercise_by_muscle_and_difficulty.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetExerciseByMuscleAndDifficulty _$GetExerciseByMuscleAndDifficultyFromJson(
        Map<String, dynamic> json) =>
    GetExerciseByMuscleAndDifficulty(
      message: json['message'] as String?,
      totalExercises: (json['totalExercises'] as num?)?.toInt(),
      totalPages: (json['totalPages'] as num?)?.toInt(),
      currentPage: (json['currentPage'] as num?)?.toInt(),
      exercises: (json['exercises'] as List<dynamic>)
          .map((e) => Exercises.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetExerciseByMuscleAndDifficultyToJson(
        GetExerciseByMuscleAndDifficulty instance) =>
    <String, dynamic>{
      'message': instance.message,
      'totalExercises': instance.totalExercises,
      'totalPages': instance.totalPages,
      'currentPage': instance.currentPage,
      'exercises': instance.exercises,
    };
