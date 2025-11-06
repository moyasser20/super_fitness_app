import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/features/home/data/repo_impl/muscles_repo_impl.dart';
import 'package:super_fitness_app/features/home/data/data_source/muscles_remote_data_source.dart';
import 'package:super_fitness_app/features/home/data/models/muscle_groups_response_model.dart';
import 'package:super_fitness_app/features/home/data/models/muscles_response_model.dart';
import 'package:super_fitness_app/features/home/data/models/muscle_group_by_id_response_model.dart';
import 'package:super_fitness_app/features/home/data/models/muscle_group_model.dart';

@GenerateMocks([MusclesRemoteDatasource])
import 'muscles_repo_impl_test.mocks.dart';

void main() {
  late MockMusclesRemoteDatasource mockDataSource;
  late MusclesRepoImpl repo;

  setUp(() {
    mockDataSource = MockMusclesRemoteDatasource();
    repo = MusclesRepoImpl(mockDataSource);
  });

  group('MusclesRepoImpl', () {
    test('getMuscleGroups returns response', () async {
      final response = MuscleGroupsResponse(message: 'msg', musclesGroup: []);
      when(mockDataSource.getMuscleGroups()).thenAnswer((_) async => response);
      final result = await repo.getMuscleGroups();
      expect(result, isA<MuscleGroupsResponse>());
      verify(mockDataSource.getMuscleGroups()).called(1);
    });
    test('getMuscleGroups throws error', () async {
      when(mockDataSource.getMuscleGroups()).thenThrow(Exception('fail'));
      expect(() async => await repo.getMuscleGroups(), throwsException);
      verify(mockDataSource.getMuscleGroups()).called(1);
    });
    test('getRandomMuscles returns response', () async {
      final response = MusclesResponse(
        message: 'msg',
        totalMuscles: 1,
        muscles: [],
      );
      when(mockDataSource.getRandomMuscles()).thenAnswer((_) async => response);
      final result = await repo.getRandomMuscles();
      expect(result, isA<MusclesResponse>());
      verify(mockDataSource.getRandomMuscles()).called(1);
    });
    test('getRandomMuscles throws error', () async {
      when(mockDataSource.getRandomMuscles()).thenThrow(Exception('fail'));
      expect(() async => await repo.getRandomMuscles(), throwsException);
      verify(mockDataSource.getRandomMuscles()).called(1);
    });
    test('getMuscleGroupById returns response', () async {
      final muscleGroup = MuscleGroup(id: 'id', name: 'Test Group');
      final response = MuscleGroupByIdResponse(
        message: 'ok',
        muscleGroup: muscleGroup,
        muscles: [],
      );
      when(
        mockDataSource.getMuscleGroupById('id'),
      ).thenAnswer((_) async => response);
      final result = await repo.getMuscleGroupById('id');
      expect(result, isA<MuscleGroupByIdResponse>());
      verify(mockDataSource.getMuscleGroupById('id')).called(1);
    });
    test('getMuscleGroupById throws error', () async {
      when(
        mockDataSource.getMuscleGroupById('id'),
      ).thenThrow(Exception('fail'));
      expect(() async => await repo.getMuscleGroupById('id'), throwsException);
      verify(mockDataSource.getMuscleGroupById('id')).called(1);
    });
  });
}
