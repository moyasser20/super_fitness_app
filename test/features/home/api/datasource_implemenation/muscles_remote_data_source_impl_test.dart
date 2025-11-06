import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/features/home/api/data_source_impl/muscles_remote_data_source_impl.dart';
import 'package:super_fitness_app/features/home/data/models/muscle_groups_response_model.dart';
import 'package:super_fitness_app/features/home/data/models/muscle_group_by_id_response_model.dart';
import 'package:super_fitness_app/features/home/data/models/muscles_response_model.dart';
import 'package:super_fitness_app/core/api/client/api_client.dart';
import 'package:super_fitness_app/features/home/data/models/muscle_group_model.dart';

@GenerateMocks([ApiClient])
import 'muscles_remote_data_source_impl_test.mocks.dart';

void main() {
  late MockApiClient mockApiClient;
  late MusclesRemoteDatasourceImpl dataSource;

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = MusclesRemoteDatasourceImpl(mockApiClient);
  });

  group('MusclesRemoteDataSourceImpl', () {
    test('getMuscleGroups returns response', () async {
      final response = MuscleGroupsResponse(message: 'msg', musclesGroup: []);
      when(mockApiClient.getMuscleGroups()).thenAnswer((_) async => response);
      final result = await dataSource.getMuscleGroups();
      expect(result, isA<MuscleGroupsResponse>());
      verify(mockApiClient.getMuscleGroups()).called(1);
    });
    test('getMuscleGroups throws error', () async {
      when(mockApiClient.getMuscleGroups()).thenThrow(Exception('fail'));
      expect(() async => await dataSource.getMuscleGroups(), throwsException);
      verify(mockApiClient.getMuscleGroups()).called(1);
    });
    test('getRandomMuscles returns response', () async {
      final response = MusclesResponse(
        message: 'ok',
        totalMuscles: 1,
        muscles: [],
      );
      when(mockApiClient.getRandomMuscles()).thenAnswer((_) async => response);
      final result = await dataSource.getRandomMuscles();
      expect(result, isA<MusclesResponse>());
      verify(mockApiClient.getRandomMuscles()).called(1);
    });
    test('getRandomMuscles throws error', () async {
      when(mockApiClient.getRandomMuscles()).thenThrow(Exception('fail'));
      expect(() async => await dataSource.getRandomMuscles(), throwsException);
      verify(mockApiClient.getRandomMuscles()).called(1);
    });
    test('getMuscleGroupById returns response', () async {
      final muscleGroup = MuscleGroup(id: 'id', name: 'Test Group');
      final response = MuscleGroupByIdResponse(
        message: 'done',
        muscleGroup: muscleGroup,
        muscles: [],
      );
      when(
        mockApiClient.getMuscleGroupById('id'),
      ).thenAnswer((_) async => response);
      final result = await dataSource.getMuscleGroupById('id');
      expect(result, isA<MuscleGroupByIdResponse>());
      verify(mockApiClient.getMuscleGroupById('id')).called(1);
    });
    test('getMuscleGroupById throws error', () async {
      when(mockApiClient.getMuscleGroupById('id')).thenThrow(Exception('fail'));
      expect(
        () async => await dataSource.getMuscleGroupById('id'),
        throwsException,
      );
      verify(mockApiClient.getMuscleGroupById('id')).called(1);
    });
  });
}
