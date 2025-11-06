// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_muscles_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllMusclesResponse _$AllMusclesResponseFromJson(Map<String, dynamic> json) =>
    AllMusclesResponse(
      message: json['message'] as String?,
      musclesGroup:
          (json['musclesGroup'] as List<dynamic>?)
              ?.map((e) => MuscleGroup.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$AllMusclesResponseToJson(AllMusclesResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'musclesGroup': instance.musclesGroup,
    };

MuscleGroup _$MuscleGroupFromJson(Map<String, dynamic> json) =>
    MuscleGroup(id: json['_id'] as String?, name: json['name'] as String?);

Map<String, dynamic> _$MuscleGroupToJson(MuscleGroup instance) =>
    <String, dynamic>{'_id': instance.id, 'name': instance.name};
