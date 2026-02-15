import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class Preference {
  static Future<String?> getSharedPref(String key) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();

    return sharedPref.getString(key);
  }

  // static Future<bool> getSharedPrefBool(String key) async {
  //   SharedPreferences sharedPref = await SharedPreferences.getInstance();
  //   return sharedPref.getBool(key)!;
  // }
  static Future<bool> getSharedPrefBool(String key) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getBool(key) ?? false; // default false if null
  }

  static saveSharedPrefString(String key, String value) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString(key, value);
  }

  static saveSharedPrefBool(String key, bool value) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.setBool(key, value);
  }

  static clearPrefData() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.clear();
  }

  static removePrefKey(String removeKey) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.remove(removeKey);
  }

  // User-specific methods
  static const String userIdKey = 'user_id';
  static const String userNameKey = 'user_name';
  static const String userPhoneKey = 'user_phone';
  static const String userRoleKey = 'user_role';
  static const String userWorkIdKey = 'user_work_id';
  static const String userBranchKey = 'user_branch';
  static const String isLoggedInKey = 'is_logged_in';

  // Save user data
  static Future<void> saveUserData(Map<String, dynamic> userData) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();

    await sharedPref.setString(userIdKey, userData['id']?.toString() ?? '');
    await sharedPref.setString(userNameKey, userData['name']?.toString() ?? '');
    await sharedPref.setString(userPhoneKey, userData['phone']?.toString() ?? '');
    await sharedPref.setString(userRoleKey, userData['role']?.toString() ?? '');
    await sharedPref.setString(userWorkIdKey, userData['work_id']?.toString() ?? '');
    await sharedPref.setString(userBranchKey, userData['branch']?.toString() ?? '');
    await sharedPref.setBool(isLoggedInKey, true);
  }

  // Get user data
  // static Future<String?> getUserId() async {
  //   return await getSharedPref(userIdKey);
  // }
  static Future<String> getUserId() async {
    return await getSharedPref(userIdKey) ?? ''; // return empty string if null
  }

  static Future<String?> getUserName() async {
    return await getSharedPref(userNameKey);
  }

  static Future<String?> getUserPhone() async {
    return await getSharedPref(userPhoneKey);
  }
  static Future<void> init() async {
    await GetStorage.init();
    await SharedPreferences.getInstance();
  }

  static Future<String?> getSharedPrefString(String key) async {
    return await getSharedPref(key);
  }

  static Future<String?> getUserRole() async {
    return await getSharedPref(userRoleKey);
  }

  static Future<String?> getUserWorkId() async {
    return await getSharedPref(userWorkIdKey);
  }

  static Future<String?> getUserBranch() async {
    return await getSharedPref(userBranchKey);
  }

  static Future<bool> isLoggedIn() async {
    return await getSharedPrefBool(isLoggedInKey);
  }

  // Clear user data (logout)
  static Future<void> clearUserData() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    await sharedPref.remove(userIdKey);
    await sharedPref.remove(userNameKey);
    await sharedPref.remove(userPhoneKey);
    await sharedPref.remove(userRoleKey);
    await sharedPref.remove(userWorkIdKey);
    await sharedPref.remove(userBranchKey);
    await sharedPref.remove(isLoggedInKey);
  }


}
