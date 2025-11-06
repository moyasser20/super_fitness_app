import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/features/exercise/data/datasource/exercise_remote_datasource.dart';
import 'package:super_fitness_app/features/exercise/data/models/difficulty_levels_response.dart';
import 'package:super_fitness_app/features/exercise/data/models/get_exercise_by_muscle_and_difficulty.dart';
import 'package:super_fitness_app/features/exercise/data/repositories_impl/exercise_repo_impl.dart';

@GenerateMocks([ExerciseRemoteDatasource])
import 'exercise_repo_impl_test.mocks.dart';

void main() {
  late ExerciseRepoImpl repository;
  late MockExerciseRemoteDatasource mockDatasource;

  const tPrimeMoverMuscleId = 'muscle_123';
  const tDifficultyLevelId = 'level_1';

  setUp(() {
    mockDatasource = MockExerciseRemoteDatasource();
    repository = ExerciseRepoImpl(mockDatasource);
  });

  group('getAllDifficultyLevels', () {
    final tResponse = DifficultyLevelResponse(
      difficultyLevels: [],
      totalLevels: 0,
    );

    test(
      'should return DifficultyLevelResponse when datasource call is successful',
      () async {
        // arrange
        when(
          mockDatasource.getAllDifficultyLevels(any),
        ).thenAnswer((_) async => tResponse);

        // act
        final result = await repository.getAllDifficultyLevels(
          tPrimeMoverMuscleId,
        );

        // assert
        expect(result, equals(tResponse));
        verify(
          mockDatasource.getAllDifficultyLevels(tPrimeMoverMuscleId),
        ).called(1);
        verifyNoMoreInteractions(mockDatasource);
      },
    );

    test('should throw Exception when datasource call fails', () async {
      // arrange
      when(
        mockDatasource.getAllDifficultyLevels(any),
      ).thenThrow(Exception('Server error'));

      // act
      final call = repository.getAllDifficultyLevels;

      // assert
      expect(() => call(tPrimeMoverMuscleId), throwsA(isA<Exception>()));
    });
  });

  group('getExerciseByMuscleAndDifficulty', () {
    final tExerciseResponse = GetExerciseByMuscleAndDifficulty(exercises: []);

    test(
      'should return GetExerciseByMuscleAndDifficulty when datasource call is successful',
      () async {
        // arrange
        when(
          mockDatasource.getExerciseByMuscleAndDifficulty(any, any),
        ).thenAnswer((_) async => tExerciseResponse);

        // act
        final result = await repository.getExerciseByMuscleAndDifficulty(
          tPrimeMoverMuscleId,
          tDifficultyLevelId,
        );

        // assert
        expect(result, equals(tExerciseResponse));
        verify(
          mockDatasource.getExerciseByMuscleAndDifficulty(
            tPrimeMoverMuscleId,
            tDifficultyLevelId,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockDatasource);
      },
    );

    test('should throw Exception when datasource call fails', () async {
      // arrange
      when(
        mockDatasource.getExerciseByMuscleAndDifficulty(any, any),
      ).thenThrow(Exception('Network error'));

      // act
      final call = repository.getExerciseByMuscleAndDifficulty;

      // assert
      expect(
        () => call(tPrimeMoverMuscleId, tDifficultyLevelId),
        throwsA(isA<Exception>()),
      );
    });
  });
}
