import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/features/home/presentation/viewmodel/home_cubit.dart';
import 'package:super_fitness_app/features/home/domain/usecases/get_muscle_group_by_id_usecase.dart';
import 'package:super_fitness_app/features/home/domain/usecases/get_muscle_groups_usecase.dart';
import 'package:super_fitness_app/features/home/domain/usecases/get_random_muscles_usecase.dart';
import 'package:super_fitness_app/features/home/data/models/muscle_model.dart';
import 'package:super_fitness_app/features/home/data/models/muscle_groups_response_model.dart';
import 'package:super_fitness_app/features/home/data/models/muscles_response_model.dart';
import 'package:super_fitness_app/features/home/data/models/muscle_group_by_id_response_model.dart';
import 'package:super_fitness_app/features/home/data/models/muscle_group_model.dart';

@GenerateMocks([
  GetRandomMusclesUseCase,
  GetMuscleGroupsUseCase,
  GetMuscleGroupByIdUseCase,
])
import 'home_cubit_test.mocks.dart';

void main() {
  late MockGetRandomMusclesUseCase mockGetRandomMusclesUseCase;
  late MockGetMuscleGroupsUseCase mockGetMuscleGroupsUseCase;
  late MockGetMuscleGroupByIdUseCase mockGetMuscleGroupByIdUseCase;
  late HomeCubit cubit;

  setUp(() {
    mockGetRandomMusclesUseCase = MockGetRandomMusclesUseCase();
    mockGetMuscleGroupsUseCase = MockGetMuscleGroupsUseCase();
    mockGetMuscleGroupByIdUseCase = MockGetMuscleGroupByIdUseCase();

    cubit = HomeCubit(
      mockGetRandomMusclesUseCase,
      mockGetMuscleGroupsUseCase,
      mockGetMuscleGroupByIdUseCase,
    );
  });

  group('HomeCubit', () {
    final musclesResponse = MusclesResponse(
      message: 'success',
      totalMuscles: 1,
      muscles: [
        Muscle(id: '1', name: 'Biceps', image: null),
      ],
    );
    final muscleGroup = MuscleGroup(id: 'g1', name: 'Upper Body');
    final muscleGroupsResponse = MuscleGroupsResponse(
      message: 'success',
      musclesGroup: [muscleGroup],
    );
    final muscleGroupByIdResponse = MuscleGroupByIdResponse(
      message: 'success',
      muscleGroup: muscleGroup,
      muscles: [Muscle(id: '1', name: 'Biceps', image: null)],
    );

    blocTest<HomeCubit, HomeState>(
      'emits [HomeLoading, HomeLoaded] when loadHomeData succeeds',
      build: () {
        when(mockGetRandomMusclesUseCase()).thenAnswer((_) async => musclesResponse);
        when(mockGetMuscleGroupsUseCase()).thenAnswer((_) async => muscleGroupsResponse);
        when(mockGetMuscleGroupByIdUseCase(any)).thenAnswer((_) async => muscleGroupByIdResponse);
        return cubit;
      },
      act: (cubit) => cubit.loadHomeData(),
      expect: () => [
        isA<HomeLoading>(),
        isA<HomeLoaded>(),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'emits [HomeLoading, HomeError] when loadHomeData fails',
      build: () {
        when(mockGetRandomMusclesUseCase()).thenThrow(Exception('fail'));
        return cubit;
      },
      act: (cubit) => cubit.loadHomeData(),
      expect: () => [
        isA<HomeLoading>(),
        isA<HomeError>(),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'emits [HomeLoading, HomeLoaded] when refreshRecommendations succeeds',
      build: () {
        when(mockGetRandomMusclesUseCase()).thenAnswer((_) async => musclesResponse);
        when(mockGetMuscleGroupsUseCase()).thenAnswer((_) async => muscleGroupsResponse);
        when(mockGetMuscleGroupByIdUseCase(any)).thenAnswer((_) async => muscleGroupByIdResponse);
        return cubit;
      },
      seed: () => HomeLoaded(
        recommendedMuscles: [],
        muscleGroups: [muscleGroup],
        userName: 'Omar',
        userImage: '',
        selectedWorkout: null,
        selectedMuscleIds: {'g1'},
      ),
      act: (cubit) => cubit.refreshRecommendations(),
      expect: () => [
        isA<HomeLoading>(),
        isA<HomeLoaded>(),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'emits HomeLoaded with new details when loadMuscleGroupDetails is called',
      build: () {
        when(mockGetMuscleGroupByIdUseCase('g1')).thenAnswer((_) async => muscleGroupByIdResponse);
        return cubit;
      },
      seed: () => HomeLoaded(
        recommendedMuscles: [],
        muscleGroups: [muscleGroup],
        userName: 'Omar',
        userImage: '',
        selectedWorkout: null,
        selectedMuscleIds: {},
      ),
      act: (cubit) => cubit.loadMuscleGroupDetails('g1'),
      expect: () => [
        isA<HomeLoaded>(),
        isA<HomeLoaded>(),
      ],
    );
  });
}
