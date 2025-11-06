import 'package:json_annotation/json_annotation.dart';
import 'muscle_model.dart';
import 'muscle_group_model.dart';

part 'muscle_group_by_id_response_model.g.dart';

@JsonSerializable()
class MuscleGroupByIdResponse {
  final String message;
  final MuscleGroup muscleGroup;
  final List<Muscle> muscles;

  MuscleGroupByIdResponse({
    required this.message,
    required this.muscleGroup,
    required this.muscles,
  });

  factory MuscleGroupByIdResponse.fromJson(Map<String, dynamic> json) =>
      _$MuscleGroupByIdResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MuscleGroupByIdResponseToJson(this);
}
