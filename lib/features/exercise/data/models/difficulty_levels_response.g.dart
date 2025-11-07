// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'difficulty_levels_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DifficultyLevelResponse _$DifficultyLevelResponseFromJson(
        Map<String, dynamic> json) =>
    DifficultyLevelResponse(
      message: json['message'] as String?,
      totalLevels: (json['totalLevels'] as num).toInt(),
      difficultyLevels: (json['difficulty_levels'] as List<dynamic>?)
          ?.map((e) => DifficultyLevels.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DifficultyLevelResponseToJson(
        DifficultyLevelResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'totalLevels': instance.totalLevels,
      'difficulty_levels': instance.difficultyLevels,
    };
