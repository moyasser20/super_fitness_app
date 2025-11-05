import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/api/client/api_client.dart';
import 'package:super_fitness_app/core/errors/api_result.dart';
import 'package:super_fitness_app/features/profile/api/datasource_impl/profile_remote_datasource_impl.dart';
import 'package:super_fitness_app/features/profile/data/datasource/profile_remote_datasource.dart';
import 'package:super_fitness_app/features/profile/data/models/profile_response.dart';
import 'package:super_fitness_app/features/profile/data/models/user_model.dart';

import 'profile_remote_datasource_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late MockApiClient mockProfileApiClient;
  late ProfileRemoteDatasource datasource;

  setUp(() {
    mockProfileApiClient = MockApiClient();
    datasource = ProfileRemoteDatasourceImpl(apiClient: mockProfileApiClient);
  });

  group('ProfileRemoteDatasourceImpl - getProfile', () {
    test('should return ApiSuccessResult when API call succeeds', () async {
      // arrange
      final fakeUser = User(
        Id: "123",
        firstName: "Mouayed",
        lastName: "Mohamed",
        email: "mouayed@example.com",
        gender: "male",
        photo: "https://example.com/photo.jpg",
        createdAt: "2025-09-01T00:00:00Z",
        age: 0,
        weight: 0,
        height: 0,
        activityLevel: '',
        goal: '',
      );

      final fakeResponse = ProfileResponse(
        message: "Profile fetched successfully",
        user: fakeUser,
      );

      when(
        mockProfileApiClient.getProfile(),
      ).thenAnswer((_) async => fakeResponse);

      // act
      final result = await datasource.getProfile();

      // assert
      expect(result, isA<ApiSuccessResult<ProfileResponse>>());
      expect(
        (result as ApiSuccessResult).data.message,
        "Profile fetched successfully",
      );
      verify(mockProfileApiClient.getProfile()).called(1);
    });

    test(
      'should return ApiErrorResult with server message when DioException thrown',
      () async {
        final dioError = DioException(
          requestOptions: RequestOptions(path: '/profile'),
          response: Response(
            requestOptions: RequestOptions(path: '/profile'),
            statusCode: 401,
            data: {'message': 'Unauthorized'},
          ),
          type: DioExceptionType.badResponse,
        );

        when(mockProfileApiClient.getProfile()).thenThrow(dioError);

        // act
        final result = await datasource.getProfile();

        // assert
        expect(result, isA<ApiErrorResult>());
        expect((result as ApiErrorResult).errorMessage, 'Unauthorized');
      },
    );

    test(
      'should return ApiErrorResult with "Unexpected error" on generic exception',
      () async {
        when(
          mockProfileApiClient.getProfile(),
        ).thenThrow(Exception('Something went wrong'));

        // act
        final result = await datasource.getProfile();

        // assert
        expect(result, isA<ApiErrorResult>());
        expect((result as ApiErrorResult).errorMessage, 'Unexpected error');
      },
    );
  });
}
