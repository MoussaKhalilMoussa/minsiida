import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_nav_bar/constants/strings.dart';

class StorageService {
  //static late final SharedPreferences _prefs;
  static final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();

  /* Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  } */

  static Future<void> setBool(String key, bool value) async {
    return await asyncPrefs.setBool(key, value);
  }

  static Future<void> setString(String key, String value) async {
    return await asyncPrefs.setString(key, value);
  }

  static Future<void> remove(String key) async {
    return await asyncPrefs.remove(key);
  }

  static String getToken() {
    return asyncPrefs.getString(authToken).toString();
  }
}
