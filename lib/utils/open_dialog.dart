import 'package:flutter/material.dart';
import 'package:get/get.dart';

void openDialog({
  required Widget widget,
  bool? barrierDismissible,
}) {
  Get.dialog(
    widget,
    barrierDismissible: barrierDismissible ?? true,
    barrierColor: Colors.black.withOpacity(0.75),
    useSafeArea: false,
  );
}
