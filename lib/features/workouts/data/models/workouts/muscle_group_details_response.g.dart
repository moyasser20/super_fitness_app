// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'muscle_group_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MuscleGroupDetailsResponse _$MuscleGroupDetailsResponseFromJson(
  Map<String, dynamic> json,
) => MuscleGroupDetailsResponse(
  message: json['message'] as String?,
  muscleGroup:
      json['muscleGroup'] == null
          ? null
          : MuscleGroupDetails.fromJson(
            json['muscleGroup'] as Map<String, dynamic>,
          ),
  muscles:
      (json['muscles'] as List<dynamic>?)
          ?.map((e) => Muscle.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$MuscleGroupDetailsResponseToJson(
  MuscleGroupDetailsResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'muscleGroup': instance.muscleGroup,
  'muscles': instance.muscles,
};

MuscleGroupDetails _$MuscleGroupDetailsFromJson(Map<String, dynamic> json) =>
    MuscleGroupDetails(
      id: json['_id'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$MuscleGroupDetailsToJson(MuscleGroupDetails instance) =>
    <String, dynamic>{'_id': instance.id, 'name': instance.name};

Muscle _$MuscleFromJson(Map<String, dynamic> json) => Muscle(
  id: json['_id'] as String?,
  name: json['name'] as String?,
  image: json['image'] as String?,
);

Map<String, dynamic> _$MuscleToJson(Muscle instance) => <String, dynamic>{
  '_id': instance.id,
  'name': instance.name,
  'image': instance.image,
};
