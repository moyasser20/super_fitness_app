import 'package:json_annotation/json_annotation.dart';

part 'muscle_group_details_response.g.dart';

@JsonSerializable()
class MuscleGroupDetailsResponse {
  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "muscleGroup")
  final MuscleGroupDetails? muscleGroup;

  @JsonKey(name: "muscles")
  final List<Muscle>? muscles;

  MuscleGroupDetailsResponse({
    this.message,
    this.muscleGroup,
    this.muscles,
  });

  factory MuscleGroupDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$MuscleGroupDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MuscleGroupDetailsResponseToJson(this);
}

@JsonSerializable()
class MuscleGroupDetails {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "name")
  final String? name;

  MuscleGroupDetails({
    this.id,
    this.name,
  });

  factory MuscleGroupDetails.fromJson(Map<String, dynamic> json) =>
      _$MuscleGroupDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$MuscleGroupDetailsToJson(this);
}

@JsonSerializable()
class Muscle {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "image")
  final String? image;

  Muscle({
    this.id,
    this.name,
    this.image,
  });

  factory Muscle.fromJson(Map<String, dynamic> json) =>
      _$MuscleFromJson(json);

  Map<String, dynamic> toJson() => _$MuscleToJson(this);
}