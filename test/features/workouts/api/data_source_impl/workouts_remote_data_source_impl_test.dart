import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:super_fitness_app/core/api/client/api_client.dart';
import 'package:super_fitness_app/features/workouts/api/data_source_impl/workouts_remote_data_source_impl.dart';
import 'package:super_fitness_app/features/workouts/data/models/workouts/all_muscles_response.dart';
import 'package:super_fitness_app/features/workouts/data/models/workouts/muscle_group_details_response.dart';

@GenerateMocks([ApiClient])
import 'workouts_remote_data_source_impl_test.mocks.dart';

void main() {
  late MockApiClient mockApiClient;
  late WorkoutsRemoteDataSourceImpl dataSource;

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = WorkoutsRemoteDataSourceImpl(mockApiClient);
  });

  group('WorkoutsRemoteDataSourceImpl', () {
    test('getAllMuscles returns success response on successful call', () async {
      final response = AllMusclesResponse(message: 'success', musclesGroup: []);
      when(mockApiClient.getAllMuscles()).thenAnswer((_) async => response);

      final result = await dataSource.getAllMuscles();

      expect(result.isSuccess, true);
      expect(result.data, response);
      expect(result.error, null);
      verify(mockApiClient.getAllMuscles()).called(1);
    });

    test('getAllMuscles returns error response on DioException', () async {
      final dioException = DioException(
        requestOptions: RequestOptions(path: ''),
        response: Response(
          requestOptions: RequestOptions(path: ''),
          data: {'error': 'API Error'},
          statusCode: 400,
        ),
      );
      when(mockApiClient.getAllMuscles()).thenThrow(dioException);

      final result = await dataSource.getAllMuscles();

      expect(result.isSuccess, false);
      expect(result.data, null);
      expect(result.error, 'API Error');
      verify(mockApiClient.getAllMuscles()).called(1);
    });

    test(
      'getAllMuscles returns error response on DioException with string data',
      () async {
        final dioException = DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(
            requestOptions: RequestOptions(path: ''),
            data: '{"error": "String API Error"}',
            statusCode: 400,
          ),
        );
        when(mockApiClient.getAllMuscles()).thenThrow(dioException);

        final result = await dataSource.getAllMuscles();

        expect(result.isSuccess, false);
        expect(result.data, null);
        expect(result.error, 'String API Error');
        verify(mockApiClient.getAllMuscles()).called(1);
      },
    );

    test('getAllMuscles returns error response on generic exception', () async {
      when(mockApiClient.getAllMuscles()).thenThrow(Exception('Generic error'));

      final result = await dataSource.getAllMuscles();

      expect(result.isSuccess, false);
      expect(result.data, null);
      expect(result.error, 'Exception: Generic error');
      verify(mockApiClient.getAllMuscles()).called(1);
    });

    test(
      'getMusclesGroup returns success response on successful call',
      () async {
        final response = MuscleGroupDetailsResponse(
          message: 'success',
          muscleGroup: null,
          muscles: [],
        );
        when(
          mockApiClient.getMusclesGroup('id'),
        ).thenAnswer((_) async => response);

        final result = await dataSource.getMusclesGroup('id');

        expect(result.isSuccess, true);
        expect(result.data, response);
        expect(result.error, null);
        verify(mockApiClient.getMusclesGroup('id')).called(1);
      },
    );

    test('getMusclesGroup returns error response on DioException', () async {
      final dioException = DioException(
        requestOptions: RequestOptions(path: ''),
        response: Response(
          requestOptions: RequestOptions(path: ''),
          data: {'message': 'Group Error'},
          statusCode: 404,
        ),
      );
      when(mockApiClient.getMusclesGroup('id')).thenThrow(dioException);

      final result = await dataSource.getMusclesGroup('id');

      expect(result.isSuccess, false);
      expect(result.data, null);
      expect(result.error, 'Group Error');
      verify(mockApiClient.getMusclesGroup('id')).called(1);
    });

    test(
      'getMusclesGroup returns error response on generic exception',
      () async {
        when(
          mockApiClient.getMusclesGroup('id'),
        ).thenThrow(Exception('Group generic error'));

        final result = await dataSource.getMusclesGroup('id');

        expect(result.isSuccess, false);
        expect(result.data, null);
        expect(result.error, 'Exception: Group generic error');
        verify(mockApiClient.getMusclesGroup('id')).called(1);
      },
    );
  });
}
