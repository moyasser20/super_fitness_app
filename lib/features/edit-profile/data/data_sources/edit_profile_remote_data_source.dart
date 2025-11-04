import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/api/client/api_client.dart';
import 'package:super_fitness_app/features/edit-profile/data/models/edit_profile_request.dart';
import 'package:super_fitness_app/features/edit-profile/data/models/edit_profile_response.dart';

import '../../../../core/errors/failure.dart';

@lazySingleton
class EditProfileRemoteDataSource {
  final ApiClient _apiClient;

  EditProfileRemoteDataSource(this._apiClient);

  Future<EditProfileResponse> editProfile(EditProfileRequest model) async {
    try {
      final response = await _apiClient.editProfile(model);
      return response;
    } on DioException catch (e) {
      final message = _extractApiMessage(e);
      throw Exception(message);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

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
}
