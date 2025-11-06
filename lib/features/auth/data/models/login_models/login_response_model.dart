import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness_app/features/auth/data/models/login_models/user_model.dart';

part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "user")
  final User? user;
  @JsonKey(name: "token")
  final String? token;

  LoginResponse({this.message, this.user, this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return _$LoginResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LoginResponseToJson(this);
  }
}
