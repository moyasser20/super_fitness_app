// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealCategory _$MealCategoryFromJson(Map<String, dynamic> json) => MealCategory(
      id: json['idCategory'] as String,
      name: json['strCategory'] as String,
      thumbnail: json['strCategoryThumb'] as String,
      description: json['strCategoryDescription'] as String,
    );

Map<String, dynamic> _$MealCategoryToJson(MealCategory instance) =>
    <String, dynamic>{
      'idCategory': instance.id,
      'strCategory': instance.name,
      'strCategoryThumb': instance.thumbnail,
      'strCategoryDescription': instance.description,
    };
