import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:finance/models/user_models.dart';

class UserDatabase {
  static const String _userKey = 'user_data';

  static Future<void> initialize() async {
    await SharedPreferences.getInstance();
  }

  static Future<void> update(UserProfile user) async {
    final prefs = await SharedPreferences.getInstance();
    String userJson = jsonEncode(user.toJson());
    await prefs.setString(_userKey, userJson);
  }

  static Future<UserProfile?> get() async {
    final prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString(_userKey);

    if (userJson != null) {
      return UserProfile.fromJson(jsonDecode(userJson));
    }
    return null;
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }
}
