part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<Muscle> recommendedMuscles;
  final List<MuscleGroup> muscleGroups;
  final String? userName;
  final String? userImage;
  final MuscleGroupByIdResponse? selectedWorkout;
  final Set<String> selectedMuscleIds;
  final bool isLoadingWorkoutSection;
  final bool isLoadingRecommendations;

  HomeLoaded({
    required this.recommendedMuscles,
    required this.muscleGroups,
    this.userName,
    this.userImage,
    this.selectedWorkout,
    this.selectedMuscleIds = const {},
    this.isLoadingWorkoutSection = false,
    this.isLoadingRecommendations = false,
  });

  HomeLoaded copyWith({
    List<Muscle>? recommendedMuscles,
    List<MuscleGroup>? muscleGroups,
    String? userName,
    String? userImage,
    MuscleGroupByIdResponse? selectedMuscleGroupDetails,
    Set<String>? selectedMuscleIds,
    bool? isLoadingMuscleGroupDetails,
  }) {
    return HomeLoaded(
      recommendedMuscles: recommendedMuscles ?? this.recommendedMuscles,
      muscleGroups: muscleGroups ?? this.muscleGroups,
      userName: userName ?? this.userName,
      userImage: userImage ?? this.userImage,
      selectedWorkout: selectedMuscleGroupDetails ?? selectedWorkout,
      selectedMuscleIds: selectedMuscleIds ?? this.selectedMuscleIds,
      isLoadingWorkoutSection:
          isLoadingMuscleGroupDetails ?? isLoadingWorkoutSection,
      isLoadingRecommendations:
          isLoadingRecommendations ?? isLoadingRecommendations,
    );
  }
}

final class HomeError extends HomeState {
  final String errorMessage;

  HomeError(this.errorMessage);
}
