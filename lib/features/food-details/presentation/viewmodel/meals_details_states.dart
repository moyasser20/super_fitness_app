import '../../domain/entities/meal_details_entity.dart';

abstract class MealDetailsState {}

class MealDetailsInitial extends MealDetailsState {}

class MealDetailsLoading extends MealDetailsState {}

class MealDetailsLoaded extends MealDetailsState {
  final MealDetailsEntity meal;

  MealDetailsLoaded(this.meal);
}

class MealDetailsError extends MealDetailsState {
  final String message;

  MealDetailsError(this.message);
}
