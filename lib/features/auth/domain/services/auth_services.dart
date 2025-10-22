import '../../../../core/contants/secure_storage.dart';

class AuthService {
  static const String tokenKey = 'auth_token';

  static Future<void> saveAuthToken(String token) async {
    await SecureStorage.write(key: tokenKey, value: token);
  }

  static Future<bool> isUserAuthenticated() async {
    final token = await SecureStorage.read(tokenKey);
    return token != null && token.isNotEmpty;
  }


  static Future<String?> getToken() async {
    return await SecureStorage.read(tokenKey);
  }

  static Future<void> logout() async {
    await SecureStorage.delete(tokenKey);
  }
}
