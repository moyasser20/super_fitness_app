import 'package:json_annotation/json_annotation.dart';

part 'muscle_model.g.dart';

@JsonSerializable()
class Muscle {
  @JsonKey(name: "_id")
  final String id;
  final String name;
  final String? image;

  Muscle({
    required this.id,
    required this.name,
    this.image,
  });

  factory Muscle.fromJson(Map<String, dynamic> json) => _$MuscleFromJson(json);

  Map<String, dynamic> toJson() => _$MuscleToJson(this);
}