import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static SharedPreferences? _preferences;

  // Initialize SharedPreferences instance.
  static Future<void> initialize() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Get a SharedPreferences instance.
  static SharedPreferences get instance {
    if (_preferences == null) {
      throw Exception(
          'SharedPreferences has not been initialized. Call SharedPreferencesUtil.initialize() first.');
    }
    return _preferences!;
  }
}
