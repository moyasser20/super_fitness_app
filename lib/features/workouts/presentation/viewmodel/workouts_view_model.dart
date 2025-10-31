import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/features/workouts/domain/usecase/workouts_use_case.dart';
import 'package:super_fitness_app/features/workouts/presentation/viewmodel/workouts_states.dart';

@injectable
class WorkoutsViewModel extends Cubit<WorkoutsState> {
  final WorkoutsUseCase _workoutsUseCase;

  @factoryMethod
  WorkoutsViewModel(this._workoutsUseCase) : super(const WorkoutsState());

  Future<void> getAllMuscles() async {
    emit(state.copyWith(allMusclesStatus: DataStatus.loading));
    try {
      final muscles = await _workoutsUseCase.invoke();
      if (muscles.isSuccess && muscles.data != null) {
        emit(
          state.copyWith(
            allMusclesStatus: DataStatus.success,
            muscleGroups: muscles.data!.musclesGroup ?? [],
          ),
        );

        if (state.muscleGroups.isNotEmpty &&
            state.muscleGroups.first.id != null) {
          getMusclesGroup(state.muscleGroups.first.id!);
        }
      } else {
        emit(
          state.copyWith(
            allMusclesStatus: DataStatus.error,
            allMusclesError: muscles.error ?? 'Unknown error',
          ),
        );
      }
    } catch (error) {
      emit(
        state.copyWith(
          allMusclesStatus: DataStatus.error,
          allMusclesError: error.toString(),
        ),
      );
    }
  }

  Future<void> getMusclesGroup(String id) async {
    emit(state.copyWith(muscleDetailsStatus: DataStatus.loading));
    try {
      final result = await _workoutsUseCase.getMusclesGroup(id);
      if (result.isSuccess && result.data != null) {
        emit(
          state.copyWith(
            muscleDetailsStatus: DataStatus.success,
            muscles: result.data!.muscles ?? [],
          ),
        );
      } else {
        emit(
          state.copyWith(
            muscleDetailsStatus: DataStatus.error,
            muscleDetailsError: result.error ?? 'Unknown error',
          ),
        );
      }
    } catch (error) {
      emit(
        state.copyWith(
          muscleDetailsStatus: DataStatus.error,
          muscleDetailsError: error.toString(),
        ),
      );
    }
  }
}
