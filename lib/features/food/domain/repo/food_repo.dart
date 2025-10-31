import '../../data/models/meals_by_category_model.dart';

abstract class FoodRepository {
  Future<MealsByCategoryModel> getMealsByCategory(String category);
}
