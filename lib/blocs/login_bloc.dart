import 'package:flutter/material.dart';
import 'package:football_hockey/services/authentication_service.dart';
import 'package:get/get.dart';

import '../app_routes.dart';

class LoginBloc extends GetxController {
  void onAppBarBackButtonTap() {
    Get.back();
  }

  final formKey = GlobalKey<FormState>();

  // email text input ----------------------------------------------------------

  final emailFocusNode = FocusNode();
  void onEmailTextSubmitted(String? value) {
    passwordFocusNode.requestFocus();
  }

  final emailTextController = TextEditingController();
  String? emailTextValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is necessary";
    }

    return null;
  }

  // password text input -------------------------------------------------------

  final passwordFocusNode = FocusNode();
  void onPasswordTextSubmitted(String? value) {
    FocusNode().requestFocus();
  }

  final passwordTextController = TextEditingController();
  String? passwordTextValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is necessary";
    }

    return null;
  }

  final passwordTextVisible = RxBool(false);
  void onPasswordVisibilityChanged() {
    passwordTextVisible.value = !passwordTextVisible.value;
  }

  // ---------------------------------------------------------------------------

  void onForgetPasswordButtonTap() {
    Get.toNamed(PageRoutes.forgetPassword);
  }

  void onLoginButtonTap() {
    final emailAddress = emailTextController.text;
    final password = passwordTextController.text;
    AuthenticationService.attemptLogin(emailAddress, password)
        .then((success) => {
              if (success) {Get.toNamed(PageRoutes.dashboard)}
            });
  }
}
