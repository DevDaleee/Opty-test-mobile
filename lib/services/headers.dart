import 'package:shared_preferences/shared_preferences.dart';

class HeadersConfig {
  static const tokenKey = 'TokenKey';
  static const entityId = 'EntityId';

  static Future<void> clearData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(tokenKey);
    prefs.remove(entityId);
  }

  static addAccessToken({
    required String accessKeyValue,
    required String userIdValue,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(tokenKey, accessKeyValue);
    await prefs.setString(entityId, userIdValue);
  }

  static Future<String?> readAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('TokenKey');
  }

  static Future<String?> readEntityId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(entityId);
  }
}
