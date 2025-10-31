import 'package:json_annotation/json_annotation.dart';
import 'difficulty_levels.dart';

part 'difficulty_levels_response.g.dart';

@JsonSerializable()
class DifficultyLevelResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "totalLevels")
  final int totalLevels;
  @JsonKey(name: "difficulty_levels")
  final List<DifficultyLevels>? difficultyLevels;

  DifficultyLevelResponse ({
    this.message,
    required this.totalLevels,
    this.difficultyLevels,
  });

  factory DifficultyLevelResponse.fromJson(Map<String, dynamic> json) {
    return _$DifficultyLevelResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DifficultyLevelResponseToJson(this);
  }
}


