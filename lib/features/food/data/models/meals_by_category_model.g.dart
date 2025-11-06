// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meals_by_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealsByCategoryModel _$MealsByCategoryModelFromJson(
  Map<String, dynamic> json,
) => MealsByCategoryModel(
  meals:
      (json['meals'] as List<dynamic>?)
          ?.map((e) => Meals.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$MealsByCategoryModelToJson(
  MealsByCategoryModel instance,
) => <String, dynamic>{'meals': instance.meals};

Meals _$MealsFromJson(Map<String, dynamic> json) => Meals(
  strMeal: json['strMeal'] as String?,
  strMealThumb: json['strMealThumb'] as String?,
  idMeal: json['idMeal'] as String?,
);

Map<String, dynamic> _$MealsToJson(Meals instance) => <String, dynamic>{
  'strMeal': instance.strMeal,
  'strMealThumb': instance.strMealThumb,
  'idMeal': instance.idMeal,
};
