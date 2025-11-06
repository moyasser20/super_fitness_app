import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/api/client/api_client.dart';
import '../../../../core/errors/api_result.dart';
import '../../data/datasource/profile_remote_datasource.dart';
import '../../data/models/profile_response.dart';

@LazySingleton(as: ProfileRemoteDatasource)
class ProfileRemoteDatasourceImpl implements ProfileRemoteDatasource {
  final ApiClient _profileApiClient;

  ProfileRemoteDatasourceImpl({required ApiClient apiClient})
    : _profileApiClient = apiClient;

  @override
  Future<ApiResult<ProfileResponse>> getProfile() async {
    try {
      final response = await _profileApiClient.getProfile();
      return ApiSuccessResult(response);
    } on DioException catch (e) {
      return ApiErrorResult(e.response?.data['message'] ?? 'Server error');
    } catch (_) {
      return ApiErrorResult('Unexpected error');
    }
  }
}
