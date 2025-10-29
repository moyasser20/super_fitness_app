import '../models/meals_model.dart';

abstract class MealsDetailsRemoteDataSource {
  Future<MealsModel> getMealById(String id);
}