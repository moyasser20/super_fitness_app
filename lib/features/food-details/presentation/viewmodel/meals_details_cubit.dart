import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/use_cases/meals_details_usecase.dart';
import 'meals_details_states.dart';

@injectable
class MealDetailsCubit extends Cubit<MealDetailsState> {
  final MealsDetailsUseCase _mealsDetailsUseCase;

  MealDetailsCubit(this._mealsDetailsUseCase) : super(MealDetailsInitial());

  Future<void> getMealById(String id) async {
    print("🔍 Meal ID Received: $id");
    emit(MealDetailsLoading());
    print("🔍 Meal ID Received: $id");

    try {
      final meal = await _mealsDetailsUseCase.getMealById(id);
      emit(MealDetailsLoaded(meal));
      print(meal);
    } catch (e) {
      emit(MealDetailsError(e.toString()));
    }
  }
}
