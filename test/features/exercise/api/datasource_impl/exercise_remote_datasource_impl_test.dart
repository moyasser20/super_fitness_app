import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/api/client/api_client.dart';
import 'package:super_fitness_app/features/exercise/api/datasource_impl/exercise_remote_datasource_impl.dart';
import 'package:super_fitness_app/features/exercise/data/models/difficulty_levels_response.dart';
import 'package:super_fitness_app/features/exercise/data/models/get_exercise_by_muscle_and_difficulty.dart';

@GenerateMocks([ApiClient])
import 'exercise_remote_datasource_impl_test.mocks.dart';

void main() {
  late ExerciseRemoteDatasourceImpl datasource;
  late MockApiClient mockApiClient;

  const tPrimeMoverMuscleId = 'muscle_123';
  const tDifficultyLevelId = 'level_1';

  setUp(() {
    mockApiClient = MockApiClient();
    datasource = ExerciseRemoteDatasourceImpl(mockApiClient);
  });

  group('getAllDifficultyLevels', () {
    final tResponse = DifficultyLevelResponse(difficultyLevels: [], totalLevels: 0);

    test('should return DifficultyLevelResponse when API call is successful', () async {
      // arrange
      when(mockApiClient.getAllDifficultyLevels(any))
          .thenAnswer((_) async => tResponse);

      // act
      final result = await datasource.getAllDifficultyLevels(tPrimeMoverMuscleId);

      // assert
      expect(result, equals(tResponse));
      verify(mockApiClient.getAllDifficultyLevels(tPrimeMoverMuscleId)).called(1);
      verifyNoMoreInteractions(mockApiClient);
    });

    test('should throw Exception when API call fails', () async {
      // arrange
      when(mockApiClient.getAllDifficultyLevels(any))
          .thenThrow(Exception('Server error'));

      // act
      final call = datasource.getAllDifficultyLevels;

      // assert
      expect(() => call(tPrimeMoverMuscleId), throwsA(isA<Exception>()));
    });
  });

  group('getExerciseByMuscleAndDifficulty', () {
    final tExerciseResponse = GetExerciseByMuscleAndDifficulty(exercises: []);

    test('should return GetExerciseByMuscleAndDifficulty when API call is successful', () async {
      // arrange
      when(mockApiClient.getExerciseByMuscleAndDifficulty(any, any))
          .thenAnswer((_) async => tExerciseResponse);

      // act
      final result = await datasource.getExerciseByMuscleAndDifficulty(
        tPrimeMoverMuscleId,
        tDifficultyLevelId,
      );

      // assert
      expect(result, equals(tExerciseResponse));
      verify(mockApiClient.getExerciseByMuscleAndDifficulty(
        tPrimeMoverMuscleId,
        tDifficultyLevelId,
      )).called(1);
      verifyNoMoreInteractions(mockApiClient);
    });

    test('should throw Exception when API call fails', () async {
      // arrange
      when(mockApiClient.getExerciseByMuscleAndDifficulty(any, any))
          .thenThrow(Exception('Network error'));

      // act
      final call = datasource.getExerciseByMuscleAndDifficulty;

      // assert
      expect(
            () => call(tPrimeMoverMuscleId, tDifficultyLevelId),
        throwsA(isA<Exception>()),
      );
    });
  });
}
