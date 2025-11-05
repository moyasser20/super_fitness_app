// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'muscle_group_by_id_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MuscleGroupByIdResponse _$MuscleGroupByIdResponseFromJson(
        Map<String, dynamic> json) =>
    MuscleGroupByIdResponse(
      message: json['message'] as String,
      muscleGroup:
          MuscleGroup.fromJson(json['muscleGroup'] as Map<String, dynamic>),
      muscles: (json['muscles'] as List<dynamic>)
          .map((e) => Muscle.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MuscleGroupByIdResponseToJson(
        MuscleGroupByIdResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'muscleGroup': instance.muscleGroup,
      'muscles': instance.muscles,
    };
