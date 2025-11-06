import 'package:injectable/injectable.dart';

import '../entities/meal_details_entity.dart';
import '../repositories/meals_details_repo.dart';

@injectable
class MealsDetailsUseCase {
  final MealsRepo _mealsDetailsRepo;
  MealsDetailsUseCase(this._mealsDetailsRepo);

  Future<MealDetailsEntity> getMealById(String id) async {
    return await _mealsDetailsRepo.getMealById(id);
  }
}
