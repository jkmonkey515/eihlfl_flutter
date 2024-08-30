import 'package:flutter/material.dart';
import 'package:football_hockey/services/user_info_service.dart';
import 'package:get/get.dart';

import '../app_routes.dart';

class CreateAccountBloc extends GetxController {
  var formLoadingProgress = 0.0.obs;
  void onAppBarBackButtonTap() {
    Get.back();
  }

  final formKey = GlobalKey<FormState>();

  // first name text input -----------------------------------------------------

  final firstNameFocusNode = FocusNode();
  void onFirstNameTextSubmitted(String? value) {
    lastNameFocusNode.requestFocus();
  }

  final firstNameTextController = TextEditingController();
  String? firstNameTextValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "First name is necessary";
    }

    return null;
  }

  // last name text input -----------------------------------------------------

  final lastNameFocusNode = FocusNode();
  void onLastNameTextSubmitted(String? value) {
    emailFocusNode.requestFocus();
  }

  final lastNameTextController = TextEditingController();
  String? lastNameTextValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Last name is necessary";
    }

    return null;
  }

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
    teamNameFocusNode.requestFocus();
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

  // team name text input ------------------------------------------------------

  final teamNameFocusNode = FocusNode();
  void onTeamNameTextSubmitted(String? value) {
    teamSupportedFocusNode.requestFocus();
  }

  final teamNameTextController = TextEditingController();
  String? teamNameTextValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Team name is necessary";
    }

    return null;
  }

  // team supported drop down --------------------------------------------------

  final teamSupportedFocusNode = FocusNode();
  void onTeamSupportedTextSubmitted(String? value) {
    teamSupportedDefaultValue.value = value;
    FocusNode().requestFocus();
  }

  final teamSupportedDefaultValue = RxnString();
  final teamSupportedValues = ["Text one", "Text two"];
  String? teamSupportedDropdownValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Team supported is necessary";
    }

    return null;
  }

  // ---------------------------------------------------------------------------

  void onContinueButtonTap() async {
    await UserInfoService.setHasCreatedAccount(true);
    Get.toNamed(PageRoutes.awaitingAccountActivation);
  }
}
