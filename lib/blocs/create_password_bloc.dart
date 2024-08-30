import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatePasswordBloc extends GetxController {
  void onAppBarBackButtonTap() {
    Get.back();
  }

  final formKey = GlobalKey<FormState>();

  // email text input ----------------------------------------------------------

  final passwordFocusNode = FocusNode();
  void onPasswordTextSubmitted(String? value) {
    confirmNewPasswordFocusNode.requestFocus();
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

  // password text input -------------------------------------------------------

  final confirmNewPasswordFocusNode = FocusNode();
  void onConfirmNewPasswordTextSubmitted(String? value) {
    FocusNode().requestFocus();
  }

  final confirmNewPasswordTextController = TextEditingController();
  String? confirmNewPasswordTextValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Confirm new password is necessary";
    }

    return null;
  }

  final confirmNewPasswordTextVisible = RxBool(false);
  void onConfirmNewPasswordVisibilityChanged() {
    confirmNewPasswordTextVisible.value = !confirmNewPasswordTextVisible.value;
  }

  // ---------------------------------------------------------------------------

  void onResetPasswordButtonTap() {
    if (formKey.currentState?.validate() ?? false) {
      // implement
    }
  }
}
