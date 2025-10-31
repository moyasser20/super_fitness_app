import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/features/food/data/datasource/food_remote_datasource.dart';
import '../../domain/repo/food_repo.dart';
import '../models/meals_by_category_model.dart';

@LazySingleton(as: FoodRepository)
class FoodRepositoryImpl implements FoodRepository {
  final FoodRemoteDatasource _remoteDataSource;

  FoodRepositoryImpl(this._remoteDataSource);

  @override
  Future<MealsByCategoryModel> getMealsByCategory(String category) {
    return _remoteDataSource.getFoodByCategory(category);
  }
}
