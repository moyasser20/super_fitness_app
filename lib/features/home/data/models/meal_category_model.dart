import 'package:json_annotation/json_annotation.dart';

part 'meal_category_model.g.dart';

@JsonSerializable()
class MealCategory {
  @JsonKey(name: 'idCategory')
  final String id;

  @JsonKey(name: 'strCategory')
  final String name;

  @JsonKey(name: 'strCategoryThumb')
  final String thumbnail;

  @JsonKey(name: 'strCategoryDescription')
  final String description;

  MealCategory({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.description,
  });

  factory MealCategory.fromJson(Map<String, dynamic> json) =>
      _$MealCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$MealCategoryToJson(this);
}