import 'package:firebase_auth/firebase_auth.dart';
import 'package:football_hockey/utils/alert.dart';
import 'package:football_hockey/services/hockey_player_service_api.dart';
import 'package:football_hockey/services/player_standing_service_api.dart';
import 'package:football_hockey/services/user_info_service.dart';
import 'package:football_hockey/utils/errors.dart';

/// A service to handle attempting to authenticate the user through Google Authentication
class AuthenticationService {
  static Future<bool> attemptLogin(emailAddress, password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      await UserInfoService.setUserEmail(emailAddress);
      try {
        await UserInfoService.saveUserName(emailAddress);
        return true;
      } catch (e) {
        if (e is AuthenticationError &&
            e.type == AuthenticationErrorType.userNotFound) {
          AlertService.showToast("The user was not found in the database");
        } else {
          AlertService.showToast("There was an internal authentication error");
        }
        return false;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' ||
          e.code == 'wrong-password' ||
          e.code == 'invalid-credential') {
        AlertService.showToast(
            "The email or password provided are incorrect ${e.code}");
      } else {
        AlertService.showToast(
            "There was an internal authentication error.  Check your internet connection ${e.code}");
      }
      return false;
    }
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    await UserInfoService.setUserEmail(null);
    await UserInfoService.setUserName(null);

    //Clear caches
    HockeyPlayerServiceAPI.clearCaches();
    PlayerStandingServiceAPI.clearCaches();

    return;
  }

  static Future<void> sendPasswordReset(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
