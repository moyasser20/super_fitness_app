// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_categories_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealCategoriesResponse _$MealCategoriesResponseFromJson(
  Map<String, dynamic> json,
) => MealCategoriesResponse(
  categories:
      (json['categories'] as List<dynamic>)
          .map((e) => MealCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$MealCategoriesResponseToJson(
  MealCategoriesResponse instance,
) => <String, dynamic>{'categories': instance.categories};
