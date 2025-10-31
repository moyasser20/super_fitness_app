import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/contants/app_images.dart';
import '../../data/models/meal_categories_response_model.dart';
import '../../data/models/meal_category_model.dart';
import '../../data/models/muscle_group_by_id_response_model.dart';
import '../../data/models/muscle_groups_response_model.dart';
import '../../data/models/muscle_model.dart';
import '../../data/models/muscle_group_model.dart';
import '../../data/models/muscles_response_model.dart';
import '../../domain/usecases/get_meal_categories_usecase.dart';
import '../../domain/usecases/get_muscle_group_by_id_usecase.dart';
import '../../domain/usecases/get_random_muscles_usecase.dart';
import '../../domain/usecases/get_muscle_groups_usecase.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetRandomMusclesUseCase _getRandomMusclesUseCase;
  final GetMuscleGroupsUseCase _getMuscleGroupsUseCase;
  final GetMuscleGroupByIdUseCase _getMuscleGroupDetailsUseCase;
  final GetMealCategoriesUseCase _getMealCategoriesUseCase;

  HomeCubit(
    this._getRandomMusclesUseCase,
    this._getMuscleGroupsUseCase,
    this._getMuscleGroupDetailsUseCase,
    this._getMealCategoriesUseCase,
  ) : super(HomeInitial());

  Future<void> loadHomeData() async {
    try {
      emit(HomeLoading());

      final MusclesResponse musclesResponse = await _getRandomMusclesUseCase();
      final MuscleGroupsResponse muscleGroupsResponse =
          await _getMuscleGroupsUseCase();

      final userName = 'Omar';
      final userImage = AppImages.mainImage;

      final muscleGroups = muscleGroupsResponse.musclesGroup;
      final MealCategoriesResponse mealCategoriesResponse = await _getMealCategoriesUseCase();
      Set<String> selectedMuscleIds = {};
      MuscleGroupByIdResponse? selectedMuscleGroupDetails;
      if (muscleGroups.isNotEmpty) {
        final firstGroupId = muscleGroups.first.id;
        selectedMuscleIds = {firstGroupId};
        selectedMuscleGroupDetails = await _getMuscleGroupDetailsUseCase(
          firstGroupId,
        );
      }

      emit(
        HomeLoaded(
          recommendedMuscles: musclesResponse.muscles,
          muscleGroups: muscleGroups,
          mealCategories: mealCategoriesResponse.categories,
          userName: userName,
          userImage: userImage,
          selectedMuscleIds: selectedMuscleIds,
          selectedWorkout: selectedMuscleGroupDetails,
        ),
      );
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  void refreshRecommendations() async {
    final currentState = state;
    if (currentState is HomeLoaded) {
      emit(HomeLoading());
      try {
        final MusclesResponse musclesResponse =
            await _getRandomMusclesUseCase();
        emit(
          currentState.copyWith(recommendedMuscles: musclesResponse.muscles),
        );
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    }
  }

  Future<void> loadMuscleGroupDetails(String groupId) async {
    final currentState = state;
    if (currentState is HomeLoaded) {
      if (currentState.selectedWorkout?.muscleGroup.id == groupId) {
        emit(
          currentState.copyWith(
            selectedMuscleGroupDetails: null,
            isLoadingMuscleGroupDetails: false,
          ),
        );
        return;
      }
      emit(currentState.copyWith(isLoadingMuscleGroupDetails: true));

      try {
        final MuscleGroupByIdResponse details =
            await _getMuscleGroupDetailsUseCase(groupId);

        emit(
          currentState.copyWith(
            selectedMuscleGroupDetails: details,
            selectedMuscleIds: const {},
            isLoadingMuscleGroupDetails: false,
          ),
        );
      } catch (e) {
        emit(currentState.copyWith(isLoadingMuscleGroupDetails: false));
      }
    }
  }
}
