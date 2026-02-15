import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static SharedPreferences? _preferences;

  /// Initialize SharedPreferences (Call this in main.dart)
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  /// Save data
  static Future<void> setString(String key, String value) async {
    await _preferences?.setString(key, value);
  }

  static Future<void> setInt(String key, int value) async {
    await _preferences?.setInt(key, value);
  }

  static Future<void> setBool(String key, bool value) async {
    await _preferences?.setBool(key, value);
  }

  static Future<void> setDouble(String key, double value) async {
    await _preferences?.setDouble(key, value);
  }

  static Future<void> setList(String key, List<String> value) async {
    await _preferences?.setStringList(key, value);
  }

  /// Get data
  static String? getString(String key) {
    return _preferences?.getString(key);
  }

  static int? getInt(String key) {
    return _preferences?.getInt(key);
  }

  static bool? getBool(String key) {
    return _preferences?.getBool(key);
  }

  static double? getDouble(String key) {
    return _preferences?.getDouble(key);
  }

  static List<String>? getList(String key) {
    return _preferences?.getStringList(key);
  }

  /// Remove specific key
  static Future<void> removeKey(String key) async {
    await _preferences?.remove(key);
  }

  /// Clear all data
  static Future<void> clear() async {
    await _preferences?.clear();
  }

  static Future<bool> isLoggedIn() async {
    _preferences ??= await SharedPreferences.getInstance();
    return _preferences?.getBool('isLoggedIn') ?? false;
  }

  static Future<void> setLoginStatus(bool status) async {
    await _preferences?.setBool('isLoggedIn', status);
  }



}
