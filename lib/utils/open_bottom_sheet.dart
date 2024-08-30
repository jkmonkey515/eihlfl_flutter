import 'package:flutter/material.dart';
import 'package:get/get.dart';

void openBottomSheet({
  required Widget widget,
  bool? isDismissible,
}) {
  Get.bottomSheet(
    widget,
    elevation: 4.0,
    isDismissible: isDismissible ?? true,
    ignoreSafeArea: true,
    isScrollControlled: true,
    backgroundColor: Theme.of(Get.context!).cardColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(6.0),
      ),
    ),
  );
}
