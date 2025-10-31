import '../../data/models/meals_by_category_model.dart';

sealed class FoodStates {}

class FoodInitial extends FoodStates {}

class FoodLoading extends FoodStates {}

class FoodCategoriesLoaded extends FoodStates{
  final List<String> categories;
  FoodCategoriesLoaded(this.categories);
}

class FoodLoaded extends FoodStates {
  final List<Meals> meals;
  FoodLoaded(this.meals);
}

class FoodError extends FoodStates {
  final String message;
  FoodError(this.message);
}