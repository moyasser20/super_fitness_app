import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: "_id")
  final String Id;
  @JsonKey(name: "firstName")
  final String firstName;
  @JsonKey(name: "lastName")
  final String lastName;
  @JsonKey(name: "email")
  final String email;
  @JsonKey(name: "gender")
  final String gender;
  @JsonKey(name: "age")
  final int age;
  @JsonKey(name: "weight")
  final int weight;
  @JsonKey(name: "height")
  final int height;
  @JsonKey(name: "activityLevel")
  final String activityLevel;
  @JsonKey(name: "goal")
  final String goal;
  @JsonKey(name: "photo")
  final String photo;
  @JsonKey(name: "createdAt")
  final String createdAt;

  User({
    required this.Id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.photo,
    required this.createdAt,
    required this.age,
    required this.weight,
    required this.height,
    required this.activityLevel,
    required this.goal,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return _$UserFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserToJson(this);
  }
}
