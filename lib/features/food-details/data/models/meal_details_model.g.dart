// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealDetailsModel _$MealDetailsModelFromJson(Map<String, dynamic> json) =>
    MealDetailsModel(
      meals: (json['meals'] as List<dynamic>?)
          ?.map((e) => MealsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MealDetailsModelToJson(MealDetailsModel instance) =>
    <String, dynamic>{
      'meals': instance.meals,
    };
