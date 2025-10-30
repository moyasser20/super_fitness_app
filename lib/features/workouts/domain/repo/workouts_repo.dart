import 'package:super_fitness_app/features/auth/domain/responses/auth_response.dart';
import 'package:super_fitness_app/features/workouts/data/models/workouts/all_muscles_response.dart';
import 'package:super_fitness_app/features/workouts/data/models/workouts/muscle_group_details_response.dart';

abstract class WorkoutsRepo {
  Future<AuthResponse<AllMusclesResponse>> getAllMuscles();
  Future<AuthResponse<MuscleGroupDetailsResponse>> getMusclesGroup(String id);
}