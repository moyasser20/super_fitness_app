import 'package:json_annotation/json_annotation.dart';
import 'meal_category_model.dart';

part 'meal_categories_response_model.g.dart';

@JsonSerializable()
class MealCategoriesResponse {
  final List<MealCategory> categories;

  MealCategoriesResponse({required this.categories});

  factory MealCategoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$MealCategoriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MealCategoriesResponseToJson(this);
}