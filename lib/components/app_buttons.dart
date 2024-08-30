import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

part 'app_buttons_de_active.dart';
part 'app_buttons_primary.dart';
part 'app_buttons_secondary.dart';
part 'app_buttons_text.dart';

enum ButtonState { initial, loading, disable }

enum ButtonSize { small, medium, large }

double buttonHeightFromSize(ButtonSize size) {
  switch (size) {
    case ButtonSize.small:
      return 48.0;
    case ButtonSize.medium:
      return 56.0;
    case ButtonSize.large:
      return 64.0;
  }
}
