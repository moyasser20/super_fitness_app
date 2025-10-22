import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/api/client/api_client.dart';
import 'package:super_fitness_app/features/auth/api/data_source_impl/auth_remote_data_source_impl.dart';
import 'package:super_fitness_app/features/auth/data/models/login_models/login_request_model.dart';
import 'package:super_fitness_app/features/auth/data/models/login_models/login_response_model.dart';
import 'package:super_fitness_app/features/auth/data/models/login_models/user_model.dart';
import 'package:super_fitness_app/features/auth/domain/responses/auth_response.dart';

import 'auth_remote_datasource_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late MockApiClient mockAuthApiClient;
  late AuthRemoteDatasourceImpl datasourceImpl;

  setUp(() {
    mockAuthApiClient = MockApiClient();
    datasourceImpl = AuthRemoteDatasourceImpl(mockAuthApiClient);
  });

  group('Test login_models response in Login Function', () {
    test('Success State for Login Response', () async {
      //Arrange
      final loginRequest = LoginRequest(
          email: "mohamedyasser192023@gmail.com",
          password: "Mohamedyasser@2003");

      final loginResponse = LoginResponse(
        message: "success",
        token: "fakeToken",
        user: User(
          Id: "68a7033aa8bca307f9df564d",
          firstName: "Elevate121",
          lastName: "Tech121",
          email: "mohamedyasser192023@gmail.com",
        ),
      );

      when(mockAuthApiClient.login(loginRequest))
          .thenAnswer((_) async => loginResponse);

      //act
      final result = await datasourceImpl.login(loginRequest);

      // Assert
      expect(result, isA<AuthResponse<LoginResponse>>());
      expect(result.data?.message, "success");
      expect(result.data?.token, "fakeToken");
      expect(result.data?.user?.firstName, "Elevate121");
      expect(result.isSuccess, true);
      verify(mockAuthApiClient.login(loginRequest)).called(1);
    });

    test('Failure State for Login Response (returns error AuthResponse)',
        () async {
      // Arrange
      final loginRequest = LoginRequest(
        email: "wrong@test.com",
        password: "wrongpass",
      );

      when(mockAuthApiClient.login(loginRequest)).thenThrow(DioException(
        requestOptions: RequestOptions(path: '/login'),
        response: Response(
          requestOptions: RequestOptions(path: '/login'),
          statusCode: 401,
          data: {'error': 'Invalid credentials'},
        ),
      ));

      //Act
      final result = await datasourceImpl.login(loginRequest);

      //Asserts
      expect(result, isA<AuthResponse<LoginResponse>>());
      expect(result.error, isNotNull);
      expect(result.isSuccess, false);
      verify(mockAuthApiClient.login(loginRequest)).called(1);
    });
  });
}
