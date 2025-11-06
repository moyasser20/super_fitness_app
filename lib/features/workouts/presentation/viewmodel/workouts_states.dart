import 'package:equatable/equatable.dart';
import 'package:super_fitness_app/features/workouts/data/models/workouts/all_muscles_response.dart';
import 'package:super_fitness_app/features/workouts/data/models/workouts/muscle_group_details_response.dart';

enum DataStatus { initial, loading, success, error }

class WorkoutsState extends Equatable {
  final DataStatus allMusclesStatus;
  final List<MuscleGroup> muscleGroups;
  final String? allMusclesError;

  final DataStatus muscleDetailsStatus;
  final List<Muscle> muscles;
  final String? muscleDetailsError;

  const WorkoutsState({
    this.allMusclesStatus = DataStatus.initial,
    this.muscleGroups = const [],
    this.allMusclesError,
    this.muscleDetailsStatus = DataStatus.initial,
    this.muscles = const [],
    this.muscleDetailsError,
  });

  WorkoutsState copyWith({
    DataStatus? allMusclesStatus,
    List<MuscleGroup>? muscleGroups,
    String? allMusclesError,
    DataStatus? muscleDetailsStatus,
    List<Muscle>? muscles,
    String? muscleDetailsError,
  }) {
    return WorkoutsState(
      allMusclesStatus: allMusclesStatus ?? this.allMusclesStatus,
      muscleGroups: muscleGroups ?? this.muscleGroups,
      allMusclesError: allMusclesError ?? this.allMusclesError,
      muscleDetailsStatus: muscleDetailsStatus ?? this.muscleDetailsStatus,
      muscles: muscles ?? this.muscles,
      muscleDetailsError: muscleDetailsError ?? this.muscleDetailsError,
    );
  }

  @override
  List<Object?> get props => [
    allMusclesStatus,
    muscleGroups,
    allMusclesError,
    muscleDetailsStatus,
    muscles,
    muscleDetailsError,
  ];
}
