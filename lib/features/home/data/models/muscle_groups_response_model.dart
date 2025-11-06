import 'package:json_annotation/json_annotation.dart';
import 'muscle_group_model.dart';

part 'muscle_groups_response_model.g.dart';

@JsonSerializable()
class MuscleGroupsResponse {
  final String message;
  final List<MuscleGroup> musclesGroup;

  MuscleGroupsResponse({required this.message, required this.musclesGroup});

  factory MuscleGroupsResponse.fromJson(Map<String, dynamic> json) =>
      _$MuscleGroupsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MuscleGroupsResponseToJson(this);
}
