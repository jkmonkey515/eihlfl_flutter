import 'package:football_hockey/app_routes.dart';
import 'package:get/get.dart';

class AwaitingAccountActivationBloc extends GetxController {
  void on() {
    Get.back();
  }

  // ---------------------------------------------------------------------------

  void onBackToLoginButtonTap() {
    Get.offNamedUntil(
        PageRoutes.splash, (route) => route.settings.name == PageRoutes.splash);
  }
}
