import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness_app/features/food-details/data/models/meals_model.dart';

part 'meal_details_model.g.dart';

@JsonSerializable()
class MealDetailsModel {
  @JsonKey(name: "meals")
  final List<MealsModel>? meals;

  MealDetailsModel ({
    this.meals,
  });

  factory MealDetailsModel.fromJson(Map<String, dynamic> json) {
    return _$MealDetailsModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MealDetailsModelToJson(this);
  }
}




