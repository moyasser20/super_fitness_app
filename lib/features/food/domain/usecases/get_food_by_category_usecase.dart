import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/features/food/domain/repo/food_repo.dart';
import '../../data/models/meals_by_category_model.dart';

@lazySingleton
class GetFoodByCategoryUseCase {
  final FoodRepository _mealsRepository;

  GetFoodByCategoryUseCase(this._mealsRepository);

  Future<MealsByCategoryModel> call(String category) {
    return _mealsRepository.getMealsByCategory(category);
  }
}
