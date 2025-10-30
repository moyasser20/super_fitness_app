import 'package:json_annotation/json_annotation.dart';

part 'all_muscles_response.g.dart';

@JsonSerializable()
class AllMusclesResponse {
  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "musclesGroup")
  final List<MuscleGroup>? musclesGroup;

  AllMusclesResponse({
    this.message,
    this.musclesGroup,
  });

  factory AllMusclesResponse.fromJson(Map<String, dynamic> json) =>
      _$AllMusclesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AllMusclesResponseToJson(this);
}

@JsonSerializable()
class MuscleGroup {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "name")
  final String? name;

  MuscleGroup({
    this.id,
    this.name,
  });

  factory MuscleGroup.fromJson(Map<String, dynamic> json) =>
      _$MuscleGroupFromJson(json);

  Map<String, dynamic> toJson() => _$MuscleGroupToJson(this);
}
