import '../entities/meal_details_entity.dart';

abstract class MealsRepo{
  Future<MealDetailsEntity> getMealById(String id);
}