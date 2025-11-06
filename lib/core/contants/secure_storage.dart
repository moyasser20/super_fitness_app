import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorage {
  static late final FlutterSecureStorage _storage;
  static bool _isInitialized = false;

  static Future<void> initialize() async {
    try {
      _storage = const FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
        iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
      );
      _isInitialized = true;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> _ensureInitialized() async {
    if (!_isInitialized) {
      await initialize();
    }
  }

  static Future<void> write({
    required String key,
    required String value,
  }) async {
    await _ensureInitialized();
    try {
      await _storage.write(key: key, value: value);
      log('SecureStorage: Written key "$key" with value "$value"');
    } catch (error, stackTrace) {
      _handleError('write', error, stackTrace, key: key);
      rethrow;
    }
  }

  static Future<String?> read(String key) async {
    await _ensureInitialized();
    try {
      final value = await _storage.read(key: key);
      log('SecureStorage: Read key "$key" -> "$value"');
      return value;
    } catch (error, stackTrace) {
      _handleError('read', error, stackTrace, key: key);
      rethrow;
    }
  }

  static Future<void> delete(String key) async {
    await _ensureInitialized();
    try {
      await _storage.delete(key: key);
    } catch (error, stackTrace) {
      _handleError('delete', error, stackTrace, key: key);
      rethrow;
    }
  }

  static Future<void> clear() async {
    try {
      await _storage.deleteAll();
    } catch (error, stackTrace) {
      _handleError('clear', error, stackTrace);
      rethrow;
    }
  }

  static Future<bool> containsKey(String key) async {
    try {
      return await _storage.containsKey(key: key);
    } catch (error, stackTrace) {
      _handleError('containsKey', error, stackTrace, key: key);
      rethrow;
    }
  }

  static Future<Map<String, String>> readAll() async {
    try {
      return await _storage.readAll();
    } catch (error, stackTrace) {
      _handleError('readAll', error, stackTrace);
      rethrow;
    }
  }

  static void _handleError(
    String operation,
    Object error,
    StackTrace stackTrace, {
    String? key,
  }) {
    log(
      'SecureStorage $operation error${key != null ? " for key: $key" : ""}: $error',
    );
  }

  static Future<void> saveToken(String token) async {
    await write(key: 'auth_token', value: token);
  }

  static Future<String?> getToken() async {
    return await read('auth_token');
  }

  static Future<void> deleteToken() async {
    await delete('auth_token');
  }

  static Future<void> saveRememberMe(bool rememberMe) async {
    await write(key: 'remember_me', value: rememberMe.toString());
  }

  static Future<bool> getRememberMe() async {
    final value = await read('remember_me');
    return value == 'true';
  }

  static Future<void> deleteRememberMe() async {
    await delete('remember_me');
  }

  static Future<void> saveUserCredentials(String email, String password) async {
    await write(key: 'remembered_email', value: email);
    await write(key: 'remembered_password', value: password);
  }

  static Future<Map<String, String?>> getRememberedCredentials() async {
    final email = await read('remembered_email');
    final password = await read('remembered_password');
    return {'email': email, 'password': password};
  }

  static Future<void> deleteRememberedCredentials() async {
    await delete('remembered_email');
    await delete('remembered_password');
  }

  static Future<void> resetForDevelopment() async {
    await delete('onboarding_seen');
    await delete('token');
    await delete('app_version');
  }

  static Future<void> clearUserData() async {
    await deleteToken();
    await deleteRememberMe();
    await deleteRememberedCredentials();
  }
}
