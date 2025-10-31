import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/features/food/presentation/viewmodel/food_states.dart';
import '../../../home/domain/usecases/get_meal_categories_usecase.dart';
import '../../domain/usecases/get_food_by_category_usecase.dart';

@injectable
class MealsCubit extends Cubit<FoodStates> {
  final GetMealCategoriesUseCase _getMealCategoriesUseCase;
  final GetFoodByCategoryUseCase _getFoodByCategoryUseCase;

  MealsCubit(this._getFoodByCategoryUseCase, this._getMealCategoriesUseCase) : super(FoodInitial());

  Future<void> loadCategories() async {
    emit(FoodLoading());
    try {
      final response = await _getMealCategoriesUseCase();
      final categories = response.categories.map((c) => c.name).toList();
      emit(FoodCategoriesLoaded(categories));
      if (categories.isNotEmpty) {
        getMealsByCategory(categories.first);
      }
    } catch (e) {
      emit(FoodError(e.toString()));
    }
  }

  Future<void> getMealsByCategory(String category) async {
    emit(FoodLoading());
    try {
      final response = await _getFoodByCategoryUseCase(category);
      emit(FoodLoaded(response.meals ?? []));
    } catch (e) {
      emit(FoodError(e.toString()));
    }
  }
}