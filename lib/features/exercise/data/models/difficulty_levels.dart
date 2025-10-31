import 'package:json_annotation/json_annotation.dart';

part 'difficulty_levels.g.dart';

@JsonSerializable()
class DifficultyLevels {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "name")
  final String name;

  DifficultyLevels ({
    required this.id,
    required this.name,
  });

  factory DifficultyLevels.fromJson(Map<String, dynamic> json) {
    return _$DifficultyLevelsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DifficultyLevelsToJson(this);
  }
}