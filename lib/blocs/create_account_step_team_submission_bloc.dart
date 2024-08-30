import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_routes.dart';

class CreateAccountStepTeamSubmissionBloc extends GetxController {
  void onAppBarBackButtonTap() {
    Get.back();
  }

  final formKey = GlobalKey<FormState>();

  // net minder drop down --------------------------------------------------------

  void onNetMinderTextSubmitted(String? value) {
    netMinderDefaultValue.value = value;
  }

  final netMinderDefaultValue = RxnString();
  final netMinderValues = ["Text one", "Text two"];
  String? netMinderDropdownValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Net minder is necessary";
    }

    return null;
  }

  // defences drop down --------------------------------------------------------

  void onDefence1TextSubmitted(String? value) {
    defence1DefaultValue.value = value;
  }

  final defence1DefaultValue = RxnString();
  final defence1Values = ["Text one", "Text two"];
  String? defence1DropdownValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Defence 1 is necessary";
    }

    return null;
  }

  void onDefence2TextSubmitted(String? value) {
    defence2DefaultValue.value = value;
  }

  final defence2DefaultValue = RxnString();
  final defence2Values = ["Text one", "Text two"];
  String? defence2DropdownValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Defence 2 is necessary";
    }

    return null;
  }

  void onDefence3TextSubmitted(String? value) {
    defence3DefaultValue.value = value;
  }

  final defence3DefaultValue = RxnString();
  final defence3Values = ["Text one", "Text two"];
  String? defence3DropdownValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Defence 3 is necessary";
    }

    return null;
  }

  void onDefence4TextSubmitted(String? value) {
    defence4DefaultValue.value = value;
  }

  final defence4DefaultValue = RxnString();
  final defence4Values = ["Text one", "Text two"];
  String? defence4DropdownValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Defence 4 is necessary";
    }

    return null;
  }

  // forwards drop down --------------------------------------------------------

  void onForward1TextSubmitted(String? value) {
    forward1DefaultValue.value = value;
  }

  final forward1DefaultValue = RxnString();
  final forward1Values = ["Text one", "Text two"];
  String? forward1DropdownValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Forward 1 is necessary";
    }

    return null;
  }

  void onForward2TextSubmitted(String? value) {
    forward2DefaultValue.value = value;
  }

  final forward2DefaultValue = RxnString();
  final forward2Values = ["Text one", "Text two"];
  String? forward2DropdownValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Forward 2 is necessary";
    }

    return null;
  }

  void onForward3TextSubmitted(String? value) {
    forward3DefaultValue.value = value;
  }

  final forward3DefaultValue = RxnString();
  final forward3Values = ["Text one", "Text two"];
  String? forward3DropdownValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Forward 3 is necessary";
    }

    return null;
  }

  void onForward4TextSubmitted(String? value) {
    forward4DefaultValue.value = value;
  }

  final forward4DefaultValue = RxnString();
  final forward4Values = ["Text one", "Text two"];
  String? forward4DropdownValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Forward 4 is necessary";
    }

    return null;
  }

  // team captain text input ---------------------------------------------------

  final teamCaptainTextController = TextEditingController();
  String? teamCaptainTextValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Team captain is necessary";
    }

    return null;
  }

  // ---------------------------------------------------------------------------

  void onContinueButtonTap() {
    Get.toNamed(PageRoutes.createAccountStepFeeAndCharity);
  }
}
