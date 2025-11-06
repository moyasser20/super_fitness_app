import 'package:json_annotation/json_annotation.dart';
import 'muscle_model.dart';

part 'muscles_response_model.g.dart';

@JsonSerializable()
class MusclesResponse {
  final String message;
  final int totalMuscles;
  final List<Muscle> muscles;

  MusclesResponse({
    required this.message,
    required this.totalMuscles,
    required this.muscles,
  });

  factory MusclesResponse.fromJson(Map<String, dynamic> json) =>
      _$MusclesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MusclesResponseToJson(this);
}
