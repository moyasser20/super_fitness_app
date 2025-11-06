import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/api/client/api_client.dart';
import 'package:super_fitness_app/core/errors/failure.dart';
import 'package:super_fitness_app/features/auth/domain/responses/auth_response.dart';
import 'package:super_fitness_app/features/workouts/data/datasource/workouts_data_source.dart';
import 'package:super_fitness_app/features/workouts/data/models/workouts/all_muscles_response.dart';
import 'package:super_fitness_app/features/workouts/data/models/workouts/muscle_group_details_response.dart';

@LazySingleton(as: WorkoutsRemoteDataSource)
class WorkoutsRemoteDataSourceImpl implements WorkoutsRemoteDataSource {
  final ApiClient _apiClient;

  WorkoutsRemoteDataSourceImpl(this._apiClient);
  String _extractApiMessage(DioException e) {
    final data = e.response?.data;
    if (data is Map) {
      return data['error'] ??
          data['message'] ??
          ServerFailure.fromDio(e).errorMessage;
    }
    if (data is String) {
      try {
        final decoded = json.decode(data);
        if (decoded is Map) {
          return decoded['error'] ??
              decoded['message'] ??
              ServerFailure.fromDio(e).errorMessage;
        }
      } catch (_) {}
    }
    return ServerFailure.fromDio(e).errorMessage;
  }

  @override
  Future<AuthResponse<AllMusclesResponse>> getAllMuscles() async {
    try {
      final result = await _apiClient.getAllMuscles();
      return AuthResponse.success(result);
    } on DioException catch (e) {
      String apiMessage = _extractApiMessage(e);
      return AuthResponse.error(apiMessage);
    } catch (e) {
      return AuthResponse.error(e.toString());
    }
  }

  @override
  Future<AuthResponse<MuscleGroupDetailsResponse>> getMusclesGroup(
    String id,
  ) async {
    try {
      final result = await _apiClient.getMusclesGroup(id);
      return AuthResponse.success(result);
    } on DioException catch (e) {
      String apiMessage = _extractApiMessage(e);
      return AuthResponse.error(apiMessage);
    } catch (e) {
      return AuthResponse.error(e.toString());
    }
  }
}
