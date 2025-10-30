import '../../data/models/meal_categories_response_model.dart';
import '../../data/models/muscle_group_by_id_response_model.dart';
import '../../data/models/muscle_groups_response_model.dart';
import '../../data/models/muscles_response_model.dart';

abstract class MusclesRepo {
  Future<MusclesResponse> getRandomMuscles();

  Future<MuscleGroupsResponse> getMuscleGroups();
  Future<MuscleGroupByIdResponse> getMuscleGroupById(String groupId);
  Future<MealCategoriesResponse> getMealCategories();

}
