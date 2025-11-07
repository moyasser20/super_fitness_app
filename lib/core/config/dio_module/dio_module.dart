import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../features/auth/domain/services/auth_services.dart';
import '../../api/api_constants/api_constants.dart';

@module
abstract class DioModule {
  @lazySingleton
  Dio dio(@Named('baseurl') String baseUrl) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        contentType: 'application/json',
        headers: {
          'Accept-Language': 'en',
        },
      ),
    );

    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final requiresAuth = options.extra['auth'] == true;

          if (requiresAuth) {
            final token = await AuthService.getToken();
            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          }

          return handler.next(options);
        },
      ),
    );

    return dio;
  }

  @lazySingleton
  @Named('mealsDio')
  Dio get mealsDio {
    final dio = Dio(
      BaseOptions(
        baseUrl: "https://www.themealdb.com/api/json/v1/1/",
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        contentType: 'application/json',
      ),
    );

    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    );

    return dio;
  }

  @Named('baseurl')
  String get baseUrl => ApiConstant.baseUrl;
}
