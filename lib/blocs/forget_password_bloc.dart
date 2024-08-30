import 'package:flutter/material.dart';
import 'package:football_hockey/services/authentication_service.dart';
import 'package:get/get.dart';

import '../app_routes.dart';

class ForgetPasswordBloc extends GetxController {
  void onAppBarBackButtonTap() {
    Get.back();
  }

  final formKey = GlobalKey<FormState>();

  // email address text input --------------------------------------------------

  final emailAddressFocusNode = FocusNode();
  void onEmailAddressTextSubmitted(String? value) {
    FocusNode().requestFocus();
  }

  final emailAddressTextController = TextEditingController();
  String? emailAddressTextValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Email address is necessary";
    }

    return null;
  }

  // ---------------------------------------------------------------------------

  void onResetPasswordButtonTap() {
    if (formKey.currentState?.validate() ?? false) {
      // TODO: Add deep link handling for checkEmail / resetPassword flow "Get.toNamed(PageRoutes.checkEmail)"
      AuthenticationService.sendPasswordReset(emailAddressTextController.text)
          .then((value) => {Get.toNamed(PageRoutes.checkEmail)});
    }
  }
}
