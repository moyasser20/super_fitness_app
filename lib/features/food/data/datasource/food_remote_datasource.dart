import 'package:super_fitness_app/features/food/data/models/meals_by_category_model.dart';

abstract class FoodRemoteDatasource {
  Future<MealsByCategoryModel> getFoodByCategory(String category);
}
