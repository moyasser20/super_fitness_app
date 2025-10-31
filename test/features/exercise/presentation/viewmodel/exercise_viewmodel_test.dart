import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/features/exercise/data/models/difficulty_levels.dart';
import 'package:super_fitness_app/features/exercise/data/models/difficulty_levels_response.dart';
import 'package:super_fitness_app/features/exercise/data/models/get_exercise_by_muscle_and_difficulty.dart';
import 'package:super_fitness_app/features/exercise/domain/use_cases/get_all_difficulty_levels_usecase.dart';
import 'package:super_fitness_app/features/exercise/domain/use_cases/get_exercise_by_muscle_and_difficulty_usecase.dart';
import 'package:super_fitness_app/features/exercise/presentation/viewmodel/exercise_states.dart';
import 'package:super_fitness_app/features/exercise/presentation/viewmodel/exercise_viewmodel.dart';

@GenerateMocks([
  GetAllDifficultyLevelsUseCase,
  GetExerciseByMuscleAndDifficultyUseCase,
])
import 'exercise_viewmodel_test.mocks.dart';

void main() {
  late ExerciseViewModel cubit;
  late MockGetAllDifficultyLevelsUseCase mockGetAllDifficultyLevelsUseCase;
  late MockGetExerciseByMuscleAndDifficultyUseCase mockGetExerciseByMuscleAndDifficultyUseCase;

  const tMuscleId = 'muscle_123';
  const tDifficultyId = 'diff_1';

  final tDifficultyLevels = [
    DifficultyLevels(id: 'diff_1', name: 'Beginner'),
    DifficultyLevels(id: 'diff_2', name: 'Advanced'),
  ];

  final tDifficultyResponse =
  DifficultyLevelResponse(difficultyLevels: tDifficultyLevels, totalLevels: 0);

  final tExerciseResponse = GetExerciseByMuscleAndDifficulty(exercises: []);

  setUp(() {
    mockGetAllDifficultyLevelsUseCase = MockGetAllDifficultyLevelsUseCase();
    mockGetExerciseByMuscleAndDifficultyUseCase =
        MockGetExerciseByMuscleAndDifficultyUseCase();

    cubit = ExerciseViewModel(
      getAllDifficultyLevelsUseCase: mockGetAllDifficultyLevelsUseCase,
      getExerciseByMuscleAndDifficultyUseCase:
      mockGetExerciseByMuscleAndDifficultyUseCase,
    );
  });

  group('ExerciseViewModel', () {
    blocTest<ExerciseViewModel, ExerciseState>(
      'emits [GetLevelsLoading, GetLevelsSuccess, ExerciseLoading, ExerciseDataLoaded] '
          'when getAllDifficultyLevels succeeds and exercises are loaded',
      build: () {
        when(mockGetAllDifficultyLevelsUseCase.call(any))
            .thenAnswer((_) async => tDifficultyResponse);
        when(mockGetExerciseByMuscleAndDifficultyUseCase.call(any, any))
            .thenAnswer((_) async => tExerciseResponse);
        return cubit;
      },
      act: (cubit) => cubit.getAllDifficultyLevels(tMuscleId),
      expect: () => [
        isA<GetLevelsLoading>(),
        isA<GetLevelsSuccess>(),
        isA<ExerciseLoading>(),
        isA<ExerciseDataLoaded>(),
      ],
      verify: (_) {
        verify(mockGetAllDifficultyLevelsUseCase.call(tMuscleId)).called(1);
        verify(mockGetExerciseByMuscleAndDifficultyUseCase.call(
          tMuscleId,
          tDifficultyId,
        )).called(1);
      },
    );

    blocTest<ExerciseViewModel, ExerciseState>(
      'emits [GetLevelsLoading, GetLevelsError] when getAllDifficultyLevels throws',
      build: () {
        when(mockGetAllDifficultyLevelsUseCase.call(any))
            .thenThrow(Exception('Server error'));
        return cubit;
      },
      act: (cubit) => cubit.getAllDifficultyLevels(tMuscleId),
      expect: () => [
        isA<GetLevelsLoading>(),
        isA<GetLevelsError>(),
      ],
    );

    blocTest<ExerciseViewModel, ExerciseState>(
      'emits [ExerciseLoading, ExerciseError] when getExerciseByMuscleAndDifficulty throws',
      build: () {
        when(mockGetExerciseByMuscleAndDifficultyUseCase.call(any, any))
            .thenThrow(Exception('Exercise fetch failed'));
        return cubit;
      },
      act: (cubit) => cubit.getExerciseByMuscleAndDifficulty(
        tMuscleId,
        tDifficultyId,
        difficultyLevels: tDifficultyLevels,
      ),
      expect: () => [
        isA<ExerciseLoading>(),
        isA<ExerciseError>(),
      ],
    );
  });

  group('Utility methods', () {
    test('extractYouTubeId should extract correct id from youtu.be link', () {
      const url = 'https://youtu.be/abc123';
      expect(cubit.extractYouTubeId(url), equals('abc123'));
    });

    test('extractYouTubeId should extract correct id from youtube.com link', () {
      const url = 'https://www.youtube.com/watch?v=xyz456';
      expect(cubit.extractYouTubeId(url), equals('xyz456'));
    });

    test('getYouTubeThumbnail should return valid thumbnail URL', () {
      const url = 'https://www.youtube.com/watch?v=xyz456';
      expect(
        cubit.getYouTubeThumbnail(url),
        equals('https://img.youtube.com/vi/xyz456/hqdefault.jpg'),
      );
    });
  });
}
