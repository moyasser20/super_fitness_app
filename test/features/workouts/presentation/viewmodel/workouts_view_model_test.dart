import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/features/auth/domain/responses/auth_response.dart';
import 'package:super_fitness_app/features/workouts/data/models/workouts/all_muscles_response.dart';
import 'package:super_fitness_app/features/workouts/data/models/workouts/muscle_group_details_response.dart';
import 'package:super_fitness_app/features/workouts/domain/usecase/workouts_use_case.dart';
import 'package:super_fitness_app/features/workouts/presentation/viewmodel/workouts_states.dart';
import 'package:super_fitness_app/features/workouts/presentation/viewmodel/workouts_view_model.dart';

@GenerateMocks([WorkoutsUseCase])
import 'workouts_view_model_test.mocks.dart';

void main() {
  late MockWorkoutsUseCase mockWorkoutsUseCase;
  late WorkoutsViewModel viewModel;

  setUp(() {
    mockWorkoutsUseCase = MockWorkoutsUseCase();
    viewModel = WorkoutsViewModel(mockWorkoutsUseCase);
  });

  tearDown(() {
    viewModel.close();
  });

  final muscleGroup = MuscleGroup(id: '1', name: 'Chest');
  final allMusclesResponse = AllMusclesResponse(
    message: 'success',
    musclesGroup: [muscleGroup],
  );

  final muscleGroupDetailsResponse = MuscleGroupDetailsResponse(
    message: 'success',
    muscleGroup: null,
    muscles: [],
  );

  group('WorkoutsViewModel', () {
    blocTest<WorkoutsViewModel, WorkoutsState>(
      'emits [loading, success] when getAllMuscles succeeds',
      build: () {
        when(mockWorkoutsUseCase.invoke())
            .thenAnswer((_) async => AuthResponse.success(allMusclesResponse));
        when(mockWorkoutsUseCase.getMusclesGroup('1'))
            .thenAnswer((_) async => AuthResponse.success(muscleGroupDetailsResponse));
        return viewModel;
      },
      act: (viewModel) => viewModel.getAllMuscles(),
      expect: () => [
        isA<WorkoutsState>().having((state) => state.allMusclesStatus, 'status', DataStatus.loading),
        isA<WorkoutsState>()
            .having((state) => state.allMusclesStatus, 'status', DataStatus.success)
            .having((state) => state.muscleGroups, 'muscleGroups', [muscleGroup]),
        isA<WorkoutsState>().having((state) => state.muscleDetailsStatus, 'muscleDetailsStatus', DataStatus.loading),
        isA<WorkoutsState>()
            .having((state) => state.muscleDetailsStatus, 'muscleDetailsStatus', DataStatus.success)
            .having((state) => state.muscles, 'muscles', []),
      ],
      verify: (_) {
        verify(mockWorkoutsUseCase.invoke()).called(1);
        verify(mockWorkoutsUseCase.getMusclesGroup('1')).called(1);
      },
    );

    blocTest<WorkoutsViewModel, WorkoutsState>(
      'emits [loading, error] when getAllMuscles fails',
      build: () {
        when(mockWorkoutsUseCase.invoke())
            .thenAnswer((_) async => AuthResponse.error('API Error'));
        return viewModel;
      },
      act: (viewModel) => viewModel.getAllMuscles(),
      expect: () => [
        isA<WorkoutsState>().having((state) => state.allMusclesStatus, 'status', DataStatus.loading),
        isA<WorkoutsState>()
            .having((state) => state.allMusclesStatus, 'status', DataStatus.error)
            .having((state) => state.allMusclesError, 'error', 'API Error'),
      ],
      verify: (_) {
        verify(mockWorkoutsUseCase.invoke()).called(1);
      },
    );

    blocTest<WorkoutsViewModel, WorkoutsState>(
      'emits [loading, error] when getAllMuscles throws exception',
      build: () {
        when(mockWorkoutsUseCase.invoke()).thenThrow(Exception('Network error'));
        return viewModel;
      },
      act: (viewModel) => viewModel.getAllMuscles(),
      expect: () => [
        isA<WorkoutsState>().having((state) => state.allMusclesStatus, 'status', DataStatus.loading),
        isA<WorkoutsState>()
            .having((state) => state.allMusclesStatus, 'status', DataStatus.error)
            .having((state) => state.allMusclesError, 'error', 'Exception: Network error'),
      ],
      verify: (_) {
        verify(mockWorkoutsUseCase.invoke()).called(1);
      },
    );


    blocTest<WorkoutsViewModel, WorkoutsState>(
      'emits [loading, success] when getMusclesGroup succeeds',
      build: () {
        when(mockWorkoutsUseCase.getMusclesGroup('1'))
            .thenAnswer((_) async => AuthResponse.success(muscleGroupDetailsResponse));
        return viewModel;
      },
      act: (viewModel) => viewModel.getMusclesGroup('1'),
      expect: () => [
        isA<WorkoutsState>().having((state) => state.muscleDetailsStatus, 'status', DataStatus.loading),
        isA<WorkoutsState>()
            .having((state) => state.muscleDetailsStatus, 'status', DataStatus.success)
            .having((state) => state.muscles, 'muscles', []),
      ],
      verify: (_) {
        verify(mockWorkoutsUseCase.getMusclesGroup('1')).called(1);
      },
    );

    blocTest<WorkoutsViewModel, WorkoutsState>(
      'emits [loading, error] when getMusclesGroup fails',
      build: () {
        when(mockWorkoutsUseCase.getMusclesGroup('1'))
            .thenAnswer((_) async => AuthResponse.error('Group Error'));
        return viewModel;
      },
      act: (viewModel) => viewModel.getMusclesGroup('1'),
      expect: () => [
        isA<WorkoutsState>().having((state) => state.muscleDetailsStatus, 'status', DataStatus.loading),
        isA<WorkoutsState>()
            .having((state) => state.muscleDetailsStatus, 'status', DataStatus.error)
            .having((state) => state.muscleDetailsError, 'error', 'Group Error'),
      ],
      verify: (_) {
        verify(mockWorkoutsUseCase.getMusclesGroup('1')).called(1);
      },
    );

    blocTest<WorkoutsViewModel, WorkoutsState>(
      'emits [loading, error] when getMusclesGroup throws exception',
      build: () {
        when(mockWorkoutsUseCase.getMusclesGroup('1')).thenThrow(Exception('Group network error'));
        return viewModel;
      },
      act: (viewModel) => viewModel.getMusclesGroup('1'),
      expect: () => [
        isA<WorkoutsState>().having((state) => state.muscleDetailsStatus, 'status', DataStatus.loading),
        isA<WorkoutsState>()
            .having((state) => state.muscleDetailsStatus, 'status', DataStatus.error)
            .having((state) => state.muscleDetailsError, 'error', 'Exception: Group network error'),
      ],
      verify: (_) {
        verify(mockWorkoutsUseCase.getMusclesGroup('1')).called(1);
      },
    );
  });
}