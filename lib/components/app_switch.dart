import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

class AppSwitch extends StatelessWidget {
  const AppSwitch({
    super.key,
    required this.value,
    required this.onValueChanged,
  });

  final bool value;
  final void Function(bool) onValueChanged;

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      width: 44.0,
      height: 24.0,
      toggleSize: 20.0,
      padding: 2.0,
      inactiveColor: const Color(0xffE0E0E0),
      inactiveToggleColor: const Color(0xffFCFCFC),
      activeColor: Get.theme.colorScheme.secondary,
      activeToggleColor: const Color(0xffFCFCFC),
      value: value,
      onToggle: onValueChanged,
    );
  }
}
