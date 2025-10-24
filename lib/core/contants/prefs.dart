import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static late SharedPreferences _prefs;

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setOnboardingSeen() async {
    await _prefs.setBool('onboarding_seen', true);
  }

  static bool isOnboardingSeen() {
    return _prefs.getBool('onboarding_seen') ?? false;
  }

  static Future<void> resetForDevelopment() async {
    await _prefs.remove('onboarding_seen');
  }
}
