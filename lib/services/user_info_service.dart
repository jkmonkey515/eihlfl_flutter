import 'package:football_hockey/services/player_standing_service_api.dart';
import 'package:football_hockey/utils/errors.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A service to handle user information and saving to the defaults
class UserInfoService {
  static const _userEmailKey = "email";
  static const _userNameKey = "name";
  static const _hasCreatedAccountKey = "hasCreatedAccount";
  static Future<void> setUserEmail(String? email) async {
    final prefs = await SharedPreferences.getInstance();
    if (email != null) {
      await prefs.setString(_userEmailKey, email);
    } else {
      await prefs.remove(_userEmailKey);
    }
  }

  static Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userEmailKey);
  }

  static Future<void> setUserName(String? name) async {
    final prefs = await SharedPreferences.getInstance();
    if (name != null) {
      await prefs.setString(_userNameKey, name);
    } else {
      await prefs.remove(_userNameKey);
    }
  }

  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userNameKey);
  }

  static Future<void> saveUserName(String email) async {
    if (email == "") {
      return;
    }

    var userName = await PlayerStandingServiceAPI.getNameFromEmail(email);
    if (userName != null) {
      UserInfoService.setUserName(userName);
    } else {
      throw AuthenticationError(AuthenticationErrorType.userNotFound);
    }
  }

  static Future<bool> hasCreatedAccount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_hasCreatedAccountKey) ?? false;
  }

  static Future<void> setHasCreatedAccount(bool created) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_hasCreatedAccountKey, created);
  }
}
