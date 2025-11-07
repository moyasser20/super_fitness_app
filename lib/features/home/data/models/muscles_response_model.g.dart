// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'muscles_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MusclesResponse _$MusclesResponseFromJson(Map<String, dynamic> json) =>
    MusclesResponse(
      message: json['message'] as String,
      totalMuscles: (json['totalMuscles'] as num).toInt(),
      muscles: (json['muscles'] as List<dynamic>)
          .map((e) => Muscle.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MusclesResponseToJson(MusclesResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'totalMuscles': instance.totalMuscles,
      'muscles': instance.muscles,
    };
