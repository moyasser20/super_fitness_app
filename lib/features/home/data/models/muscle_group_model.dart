import 'package:json_annotation/json_annotation.dart';

part 'muscle_group_model.g.dart';

@JsonSerializable()
class MuscleGroup {
  @JsonKey(name: "_id")
  final String id;
  final String name;

  MuscleGroup({
    required this.id,
    required this.name,
  });

  factory MuscleGroup.fromJson(Map<String, dynamic> json) =>
      _$MuscleGroupFromJson(json);

  Map<String, dynamic> toJson() => _$MuscleGroupToJson(this);
}