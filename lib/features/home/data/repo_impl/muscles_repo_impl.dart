import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/features/home/data/models/muscle_groups_response_model.dart';

import '../../domain/repos/muscles_repo.dart';
import '../data_source/muscles_remote_data_source.dart';
import '../models/meal_categories_response_model.dart';
import '../models/muscle_group_by_id_response_model.dart';
import '../models/muscles_response_model.dart';

@LazySingleton(as: MusclesRepo)
class MusclesRepoImpl implements MusclesRepo {
  final MusclesRemoteDatasource _remoteDatasource;

  MusclesRepoImpl(this._remoteDatasource);

  @override
  Future<MusclesResponse> getRandomMuscles() async {
    return await _remoteDatasource.getRandomMuscles();
  }

  @override
  Future<MuscleGroupsResponse> getMuscleGroups() async {
    return await _remoteDatasource.getMuscleGroups();
  }
  @override
  Future<MuscleGroupByIdResponse> getMuscleGroupById(String groupId) async {
    return await _remoteDatasource.getMuscleGroupById(groupId);
  }
  @override
  Future<MealCategoriesResponse> getMealCategories() async {
    return await _remoteDatasource.getMealCategories();
  }
}
