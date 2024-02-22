import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'index.dart';

late SharedPreferences prefs;
initializePreferences() async {
  prefs = await SharedPreferences.getInstance();
}

class UserPreferences {
  static User get user =>
      User.fromJson(jsonDecode(prefs.getString(keyUser) ?? '{}'));

  static set user(User user) {
    prefs.setString(keyUser, jsonEncode(user.toJson()));
  }

  static bool get userSignedIn => prefs.getBool(keySignedIn) ?? false;

  static set userSignedIn(bool userSignedIn) {
    prefs.setBool(keySignedIn, userSignedIn);
  }

  static bool get rememberMe => prefs.getBool(keyRememberMe) ?? false;

  static Map<String, String?> getCredentials() {
    final String? username = prefs.getString(keyUsername);
    final String? password = prefs.getString(keyPassword);
    return {'username': username, 'password': password};
  }

  static void setCredentials(String username, String password) {
    prefs.setString(keyUsername, username);
    prefs.setString(keyPassword, password);
  }
}
