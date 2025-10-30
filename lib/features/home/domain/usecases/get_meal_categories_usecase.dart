import 'package:injectable/injectable.dart';
import '../../data/models/meal_categories_response_model.dart';
import '../repos/muscles_repo.dart';

@injectable
class GetMealCategoriesUseCase {
  final MusclesRepo _musclesRepo;

  GetMealCategoriesUseCase(this._musclesRepo);

  Future<MealCategoriesResponse> call() async {
    return await _musclesRepo.getMealCategories();
  }
}