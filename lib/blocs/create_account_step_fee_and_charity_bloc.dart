import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:football_hockey/app_routes.dart';
import 'package:football_hockey/services/user_info_service.dart';
import 'package:football_hockey/utils/alert.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class CreateAccountStepFeeAndCharityBloc extends GetxController {
  void onAppBarBackButtonTap() {
    Get.back();
  }

  final formKey = GlobalKey<FormState>();

  // team captain text input ---------------------------------------------------

  final entriesAllowedTextController = TextEditingController();
  String? entriesAllowedTextValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Entries allowed is necessary";
    }

    return null;
  }

  // ---------------------------------------------------------------------------

  void onRestoreButtonTap() async {
    try {
      CustomerInfo customerInfo = await Purchases.restorePurchases();
      if (customerInfo.entitlements.all["yearly_subscription_v1"]?.isActive ??
          false) {
        Get.toNamed(PageRoutes.createAccount);
      } else {
        AlertService.showToast(
            "We were unable to begin your subscription.  Reach out to customer support if this is an unexpected result of your purchase.");
      }
    } on PlatformException catch (e) {
      AlertService.showToast(
          "There was an unexpected error whenever attempting to restore your subscription");
      print(e);
    }
  }

  void onSubmitButtonTap() async {
    try {
      Offerings offerings = await Purchases.getOfferings();
      if (offerings.current != null &&
          offerings.current!.availablePackages.isNotEmpty) {
        try {
          if (offerings.current!.annual != null) {
            CustomerInfo customerInfo =
                await Purchases.purchasePackage(offerings.current!.annual!);
            if (customerInfo
                    .entitlements.all["yearly_subscription_v1"]?.isActive ??
                false) {
              Get.toNamed(PageRoutes.createAccount);
            } else {
              AlertService.showToast(
                  "We were unable to begin your subscription.  Reach out to customer support if this is an unexpected result of your purchase.");
            }
          }
        } on PlatformException catch (e) {
          var errorCode = PurchasesErrorHelper.getErrorCode(e);
          if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
            AlertService.showToast(
                "There was an unexpected error whenever attempting to access your subscription.  Please try again later.");
            print(e);
          }
        }
        // Display packages for sale
      }
    } on PlatformException catch (e) {
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        print(e);
      }
    }
    // Get.toNamed(PageRoutes.createAccount);
  }
}
