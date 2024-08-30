import 'package:flutter/services.dart';
import 'package:football_hockey/services/user_info_service.dart';
import 'package:football_hockey/utils/alert.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app_routes.dart';

class SplashBloc extends GetxController {
  void onSignUpButtonTap() async {
    try {
      CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      if (customerInfo.entitlements.all["yearly_subscription_v1"]?.isActive ??
          false) {
        var hasCreatedAccount = await UserInfoService.hasCreatedAccount();
        if (hasCreatedAccount) {
          //If the account has been created, go to awaiting account activation
          Get.toNamed(PageRoutes.awaitingAccountActivation);
        } else {
          // Still needs to create an account
          Get.toNamed(PageRoutes.createAccount);
        }
      } else {
        // Still needs to pay for the account
        Get.toNamed(PageRoutes.createAccountStepFeeAndCharity);
      }
    } catch (e) {
      print(e);
      AlertService.showToast(
          "There was an error whenever attempting the subscription account.  Please try again later.");
      Get.toNamed(PageRoutes.createAccountStepFeeAndCharity);
    }
  }

  void onLogInButtonTap() {
    Get.toNamed(PageRoutes.login);
  }

  void onTermsAndConditionsButtonTap() {
    // implement it
  }

  void onPrivacyPolicyButtonTap() {
    // implement it
  }
}
