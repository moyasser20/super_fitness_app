import 'package:json_annotation/json_annotation.dart';

part 'meals_by_category_model.g.dart';

@JsonSerializable()
class MealsByCategoryModel {
  @JsonKey(name: "meals")
  final List<Meals>? meals;

  MealsByCategoryModel ({
    this.meals,
  });

  factory MealsByCategoryModel.fromJson(Map<String, dynamic> json) {
    return _$MealsByCategoryModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MealsByCategoryModelToJson(this);
  }
}

@JsonSerializable()
class Meals {
  @JsonKey(name: "strMeal")
  final String? strMeal;
  @JsonKey(name: "strMealThumb")
  final String? strMealThumb;
  @JsonKey(name: "idMeal")
  final String? idMeal;

  Meals ({
    this.strMeal,
    this.strMealThumb,
    this.idMeal,
  });

  factory Meals.fromJson(Map<String, dynamic> json) {
    return _$MealsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MealsToJson(this);
  }
}


