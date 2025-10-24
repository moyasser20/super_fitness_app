// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      gender: json['gender'] as String,
      age: (json['age'] as num).toInt(),
      weight: (json['weight'] as num).toInt(),
      height: (json['height'] as num).toInt(),
      activityLevel: json['activityLevel'] as String,
      goal: json['goal'] as String,
      photo: json['photo'] as String,
      id: json['_id'] as String,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'gender': instance.gender,
      'age': instance.age,
      'weight': instance.weight,
      'height': instance.height,
      'activityLevel': instance.activityLevel,
      'goal': instance.goal,
      'photo': instance.photo,
      '_id': instance.id,
      'createdAt': instance.createdAt,
    };
